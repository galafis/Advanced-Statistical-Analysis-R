# =============================================================================
# TIME SERIES ANALYSIS / ANÁLISE DE SÉRIES TEMPORAIS
# =============================================================================
# Description: Advanced time series analysis functions
# Descrição: Funções avançadas para análise de séries temporais
# Author: Generated for Advanced Statistical Analysis R Package
# Date: 2025-09-09
# =============================================================================

#' Comprehensive Time Series Analysis
#' Análise Abrangente de Séries Temporais
#'
#' @description Performs comprehensive time series analysis including decomposition, forecasting, and diagnostics
#' @description Realiza análise abrangente de séries temporais incluindo decomposição, previsão e diagnósticos
#' @param data numeric vector or time series object
#' @param frequency numeric, frequency of the time series (default: 12 for monthly data)
#' @param forecast_horizon integer, number of periods to forecast (default: 12)
#' @param decomposition_method character, "stl", "classical", or "x13" (default: "stl")
#' @param plot logical, whether to generate plots (default: TRUE)
#' @return list containing time series analysis results
#' @export
#' @examples
#' # English example with monthly data
#' set.seed(123)
#' monthly_sales <- ts(cumsum(rnorm(60, 100, 20)) + 
#'                    sin(2*pi*(1:60)/12)*50, 
#'                    start=c(2020,1), frequency=12)
#' ts_result <- robust_ts_analysis(monthly_sales, forecast_horizon=6)
#' print(ts_result$forecast_summary)
#' 
#' # Exemplo em português com dados trimestrais
#' vendas_trimestrais <- ts(cumsum(rnorm(20, 1000, 100)), 
#'                         start=c(2020,1), frequency=4)
#' resultado_ts <- robust_ts_analysis(vendas_trimestrais, forecast_horizon=4)
#' print(resultado_ts$forecast_summary)
robust_ts_analysis <- function(data, frequency = 12, forecast_horizon = 12, 
                              decomposition_method = "stl", plot = TRUE) {
  
  # Load required packages (install if needed)
  required_packages <- c("forecast", "zoo")
  missing_packages <- required_packages[!required_packages %in% installed.packages()[,"Package"]]
  
  if (length(missing_packages) > 0) {
    warning(paste("Installing missing packages:", paste(missing_packages, collapse=", ")))
    install.packages(missing_packages)
  }
  
  # Load packages
  suppressMessages({
    library(forecast)
    library(zoo)
  })
  
  # Input validation / Validação de entrada
  if (!is.numeric(data) && !is.ts(data)) {
    stop("Data must be numeric or time series / Dados devem ser numéricos ou série temporal")
  }
  
  # Convert to time series if needed / Converter para série temporal se necessário
  if (!is.ts(data)) {
    data <- ts(data, frequency = frequency)
    warning("Data converted to time series object / Dados convertidos para objeto de série temporal")
  }
  
  # Remove missing values / Remover valores ausentes
  if (any(is.na(data))) {
    data <- na.fill(data, "extend")
    warning("Missing values filled using extend method / Valores ausentes preenchidos usando método extend")
  }
  
  # Basic statistics / Estatísticas básicas
  basic_stats <- list(
    length = length(data),
    start = start(data),
    end = end(data),
    frequency = frequency(data),
    mean = mean(data),
    median = median(data),
    sd = sd(data),
    min = min(data),
    max = max(data)
  )
  
  # Decomposition / Decomposição
  decomp_result <- tryCatch({
    if (decomposition_method == "stl" && frequency(data) > 1) {
      stl(data, s.window = "periodic")
    } else if (decomposition_method == "classical" && frequency(data) > 1) {
      decompose(data)
    } else {
      NULL
    }
  }, error = function(e) {
    warning(paste("Decomposition failed:", e$message, "/ Decomposição falhou:", e$message))
    NULL
  })
  
  # Stationarity tests / Testes de estacionariedade
  adf_test <- tryCatch({
    adf.test(data, alternative = "stationary")
  }, error = function(e) {
    warning("ADF test failed / Teste ADF falhou")
    NULL
  })
  
  kpss_test <- tryCatch({
    kpss.test(data)
  }, error = function(e) {
    warning("KPSS test failed / Teste KPSS falhou")
    NULL
  })
  
  # Auto ARIMA modeling / Modelagem ARIMA automática
  arima_model <- tryCatch({
    auto.arima(data, seasonal = frequency(data) > 1)
  }, error = function(e) {
    warning(paste("ARIMA modeling failed:", e$message, "/ Modelagem ARIMA falhou:", e$message))
    NULL
  })
  
  # Forecasting / Previsão
  forecast_result <- NULL
  if (!is.null(arima_model)) {
    forecast_result <- tryCatch({
      forecast(arima_model, h = forecast_horizon)
    }, error = function(e) {
      warning(paste("Forecasting failed:", e$message, "/ Previsão falhou:", e$message))
      NULL
    })
  }
  
  # Forecast accuracy metrics / Métricas de precisão da previsão
  accuracy_metrics <- NULL
  if (!is.null(arima_model)) {
    accuracy_metrics <- tryCatch({
      accuracy(arima_model)
    }, error = function(e) {
      warning("Accuracy calculation failed / Cálculo de precisão falhou")
      NULL
    })
  }
  
  # Generate plots / Gerar gráficos
  if (plot) {
    par(mfrow = c(2, 2))
    
    # Plot 1: Original time series
    plot(data, main = "Original Time Series / Série Temporal Original",
         ylab = "Values / Valores", xlab = "Time / Tempo")
    
    # Plot 2: Decomposition
    if (!is.null(decomp_result)) {
      plot(decomp_result, main = "Time Series Decomposition / Decomposição da Série Temporal")
    } else {
      # ACF plot as alternative
      acf(data, main = "Autocorrelation Function / Função de Autocorrelação")
    }
    
    # Plot 3: PACF
    pacf(data, main = "Partial Autocorrelation Function / Função de Autocorrelação Parcial")
    
    # Plot 4: Forecast
    if (!is.null(forecast_result)) {
      plot(forecast_result, main = "Forecast / Previsão",
           xlab = "Time / Tempo", ylab = "Values / Valores")
    } else {
      # Residuals plot as alternative
      if (!is.null(arima_model)) {
        plot(residuals(arima_model), main = "Model Residuals / Resíduos do Modelo",
             ylab = "Residuals / Resíduos", xlab = "Time / Tempo")
      }
    }
    
    par(mfrow = c(1, 1))
  }
  
  # Create forecast summary / Criar resumo da previsão
  forecast_summary <- NULL
  if (!is.null(forecast_result)) {
    forecast_summary <- data.frame(
      Period = 1:forecast_horizon,
      Point_Forecast = as.numeric(forecast_result$mean),
      Lo_80 = as.numeric(forecast_result$lower[,1]),
      Hi_80 = as.numeric(forecast_result$upper[,1]),
      Lo_95 = if(ncol(forecast_result$lower) > 1) as.numeric(forecast_result$lower[,2]) else NA,
      Hi_95 = if(ncol(forecast_result$upper) > 1) as.numeric(forecast_result$upper[,2]) else NA
    )
  }
  
  # Compile results / Compilar resultados
  result <- list(
    original_data = data,
    basic_stats = basic_stats,
    decomposition = decomp_result,
    stationarity_tests = list(
      adf = adf_test,
      kpss = kpss_test
    ),
    model = arima_model,
    forecast = forecast_result,
    forecast_summary = forecast_summary,
    accuracy_metrics = accuracy_metrics,
    forecast_horizon = forecast_horizon
  )
  
  class(result) <- "robust_ts_analysis"
  return(result)
}

#' Print method for robust_ts_analysis
#' @export
print.robust_ts_analysis <- function(x, ...) {
  cat("\n=== Time Series Analysis Results / Resultados da Análise de Séries Temporais ===\n\n")
  
  cat("Basic Statistics / Estatísticas Básicas:\n")
  cat(sprintf("  Length / Comprimento: %d\n", x$basic_stats$length))
  cat(sprintf("  Frequency / Frequência: %d\n", x$basic_stats$frequency))
  cat(sprintf("  Mean / Média: %.4f\n", x$basic_stats$mean))
  cat(sprintf("  Standard Deviation / Desvio Padrão: %.4f\n", x$basic_stats$sd))
  
  if (!is.null(x$model)) {
    cat("\nModel / Modelo:\n")
    print(x$model)
  }
  
  if (!is.null(x$stationarity_tests$adf)) {
    cat(sprintf("\nADF Test p-value / Valor p do Teste ADF: %.4f\n", 
                x$stationarity_tests$adf$p.value))
  }
  
  if (!is.null(x$forecast_summary)) {
    cat("\nForecast Summary / Resumo da Previsão (first 6 periods / primeiros 6 períodos):\n")
    print(head(x$forecast_summary))
  }
}

# Example usage / Exemplo de uso
if (FALSE) {
  # English example: Simulated monthly retail sales
  set.seed(123)
  months <- 1:48
  trend <- 1000 + 10 * months
  seasonal <- 200 * sin(2 * pi * months / 12)
  noise <- rnorm(48, 0, 50)
  retail_sales <- ts(trend + seasonal + noise, 
                     start = c(2020, 1), frequency = 12)
  
  # Perform comprehensive time series analysis
  ts_analysis <- robust_ts_analysis(
    data = retail_sales,
    forecast_horizon = 12,
    decomposition_method = "stl",
    plot = TRUE
  )
  
  # View results
  print(ts_analysis)
  
  # Access specific components
  cat("\nModel AIC:", ts_analysis$model$aic)
  cat("\nNext 6 months forecast:\n")
  print(ts_analysis$forecast_summary[1:6, ])
  
  # Exemplo em português: dados de temperatura mensal
  set.seed(456)
  meses <- 1:36
  temperatura_base <- 20 + 10 * cos(2 * pi * meses / 12)
  ruido <- rnorm(36, 0, 2)
  temperatura_mensal <- ts(temperatura_base + ruido,
                          start = c(2021, 1), frequency = 12)
  
  # Realizar análise de séries temporais
  analise_temperatura <- robust_ts_analysis(
    data = temperatura_mensal,
    forecast_horizon = 6,
    decomposition_method = "stl",
    plot = TRUE
  )
  
  # Visualizar resultados
  print(analise_temperatura)
  
  # Acessar componentes específicos
  cat("\nAIC do modelo:", analise_temperatura$model$aic)
  cat("\nPrevisão para os próximos 6 meses:\n")
  print(analise_temperatura$forecast_summary)
}
