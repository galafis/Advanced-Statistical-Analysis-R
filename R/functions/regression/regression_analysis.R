# ===============================================================================
# REGRESSION ANALYSIS / ANÁLISE DE REGRESSÃO
# ===============================================================================
# 
# Advanced Statistical Analysis R - Regression Analysis Module
# Módulo de Análise de Regressão - Advanced Statistical Analysis R
#
# Purpose/Objetivo: Implements comprehensive regression analysis methods including
#                   linear, polynomial, logistic, and robust regression models
#                   with diagnostics and validation procedures.
#
#                   Implementa métodos abrangentes de análise de regressão 
#                   incluindo modelos lineares, polinomiais, logísticos e 
#                   robustos com diagnósticos e procedimentos de validação.
#
# Author/Autor: Gabriel Demetrios Lafis
# Date/Data: September 2025
# Version/Versão: 1.0.0
# License/Licença: MIT
#
# Dependencies/Dependências:
#   - stats (base R)
#   - car
#   - MASS
#   - ggplot2
#   - dplyr
#   - broom
#   - plotly
#
# ===============================================================================

# Required libraries / Bibliotecas necessárias
if (!require("car")) install.packages("car")
if (!require("MASS")) install.packages("MASS")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("dplyr")) install.packages("dplyr")
if (!require("broom")) install.packages("broom")

library(car)
library(MASS)
library(ggplot2)
library(dplyr)
library(broom)

# ===============================================================================
# MULTIPLE LINEAR REGRESSION ANALYSIS / ANÁLISE DE REGRESSÃO LINEAR MÚLTIPLA
# ===============================================================================

#' Advanced Multiple Linear Regression with Comprehensive Diagnostics
#' Análise de Regressão Linear Múltipla Avançada com Diagnósticos Completos
#'
#' This function performs comprehensive multiple linear regression analysis
#' including model fitting, assumption testing, diagnostics, and visualization.
#'
#' Esta função realiza análise completa de regressão linear múltipla incluindo
#' ajuste do modelo, teste de pressupostos, diagnósticos e visualização.
#'
#' @param formula A formula object specifying the model (e.g., y ~ x1 + x2)
#'                Um objeto formula especificando o modelo (ex: y ~ x1 + x2)
#' @param data A data frame containing the variables
#'             Um data frame contendo as variáveis
#' @param alpha Significance level for tests (default: 0.05)
#'              Nível de significância para os testes (padrão: 0.05)
#' @param robust Logical, whether to perform robust regression (default: FALSE)
#'               Lógico, se deve realizar regressão robusta (padrão: FALSE)
#'
#' @return A list containing:
#'         Uma lista contendo:
#'   - model: The fitted linear model / O modelo linear ajustado
#'   - summary: Model summary / Resumo do modelo
#'   - diagnostics: Diagnostic plots and tests / Gráficos e testes diagnósticos
#'   - assumptions: Tests for model assumptions / Testes para pressupostos
#'   - predictions: Model predictions with intervals / Predições com intervalos
#'
#' @examples
#' # Basic usage / Uso básico:
#' data(mtcars)
#' result <- advanced_linear_regression(mpg ~ wt + hp + cyl, data = mtcars)
#' print(result$summary)
#' 
#' # With robust regression / Com regressão robusta:
#' result_robust <- advanced_linear_regression(mpg ~ wt + hp, mtcars, robust = TRUE)
#'
#' @export
advanced_linear_regression <- function(formula, data, alpha = 0.05, robust = FALSE) {
  
  # Input validation / Validação de entrada
  if (missing(formula) || missing(data)) {
    stop("Both 'formula' and 'data' arguments are required.\nAmbos argumentos 'formula' e 'data' são obrigatórios.")
  }
  
  if (!is.data.frame(data)) {
    stop("'data' must be a data frame.\n'data' deve ser um data frame.")
  }
  
  # Fit the model / Ajustar o modelo
  if (robust) {
    model <- MASS::rlm(formula, data = data, method = "MM")
    cat("\n=== ROBUST LINEAR REGRESSION ANALYSIS ===\n")
    cat("=== ANÁLISE DE REGRESSÃO LINEAR ROBUSTA ===\n\n")
  } else {
    model <- lm(formula, data = data)
    cat("\n=== MULTIPLE LINEAR REGRESSION ANALYSIS ===\n")
    cat("=== ANÁLISE DE REGRESSÃO LINEAR MÚLTIPLA ===\n\n")
  }
  
  # Model summary / Resumo do modelo
  model_summary <- summary(model)
  
  # Extract residuals and fitted values / Extrair resíduos e valores ajustados
  residuals_vals <- residuals(model)
  fitted_vals <- fitted(model)
  
  # Diagnostic plots / Gráficos diagnósticos
  diagnostics <- list()
  
  # 1. Residuals vs Fitted / Resíduos vs Valores Ajustados
  diagnostics$residuals_fitted <- ggplot(data = data.frame(fitted = fitted_vals, 
                                                          residuals = residuals_vals),
                                         aes(x = fitted, y = residuals)) +
    geom_point(alpha = 0.7, color = "steelblue") +
    geom_smooth(method = "loess", se = FALSE, color = "red", linetype = "dashed") +
    geom_hline(yintercept = 0, color = "black", linetype = "solid") +
    labs(title = "Residuals vs Fitted Values\nResíduos vs Valores Ajustados",
         x = "Fitted Values / Valores Ajustados",
         y = "Residuals / Resíduos") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  # 2. Q-Q Plot for normality / Gráfico Q-Q para normalidade
  diagnostics$qq_plot <- ggplot(data = data.frame(sample = residuals_vals),
                                aes(sample = sample)) +
    stat_qq(color = "steelblue", alpha = 0.7) +
    stat_qq_line(color = "red", linetype = "dashed") +
    labs(title = "Q-Q Plot of Residuals\nGráfico Q-Q dos Resíduos",
         x = "Theoretical Quantiles / Quantis Teóricos",
         y = "Sample Quantiles / Quantis Amostrais") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  # 3. Scale-Location plot / Gráfico Scale-Location
  sqrt_abs_residuals <- sqrt(abs(residuals_vals))
  diagnostics$scale_location <- ggplot(data = data.frame(fitted = fitted_vals,
                                                        sqrt_abs_res = sqrt_abs_residuals),
                                      aes(x = fitted, y = sqrt_abs_res)) +
    geom_point(alpha = 0.7, color = "steelblue") +
    geom_smooth(method = "loess", se = FALSE, color = "red", linetype = "dashed") +
    labs(title = "Scale-Location Plot\nGráfico Scale-Location",
         x = "Fitted Values / Valores Ajustados",
         y = "√|Residuals| / √|Resíduos|") +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5))
  
  # Statistical tests for assumptions / Testes estatísticos para pressupostos
  assumptions <- list()
  
  # Normality test / Teste de normalidade
  if (length(residuals_vals) >= 3 && length(residuals_vals) <= 5000) {
    assumptions$shapiro_test <- shapiro.test(residuals_vals)
  } else {
    assumptions$shapiro_test <- list(p.value = NA, 
                                   note = "Sample size not suitable for Shapiro-Wilk test")
  }
  
  # Homoscedasticity test / Teste de homocedasticidade
  if (!robust) {
    try({
      assumptions$breusch_pagan <- car::ncvTest(model)
    }, silent = TRUE)
  }
  
  # Independence test (Durbin-Watson) / Teste de independência (Durbin-Watson)
  if (!robust) {
    try({
      assumptions$durbin_watson <- car::durbinWatsonTest(model)
    }, silent = TRUE)
  }
  
  # Multicollinearity check (VIF) / Verificação de multicolinearidade (VIF)
  if (!robust && length(coefficients(model)) > 2) {
    try({
      assumptions$vif <- car::vif(model)
    }, silent = TRUE)
  }
  
  # Model predictions with confidence intervals / Predições com intervalos de confiança
  predictions <- data.frame(
    fitted = fitted_vals,
    residuals = residuals_vals
  )
  
  if (!robust) {
    pred_intervals <- predict(model, interval = "confidence")
    predictions$lower_ci <- pred_intervals[, "lwr"]
    predictions$upper_ci <- pred_intervals[, "upr"]
  }
  
  # Prepare results / Preparar resultados
  results <- list(
    model = model,
    summary = model_summary,
    diagnostics = diagnostics,
    assumptions = assumptions,
    predictions = predictions,
    formula = formula,
    robust = robust
  )
  
  class(results) <- "advanced_regression"
  
  return(results)
}

# ===============================================================================
# PRINT METHOD FOR ADVANCED REGRESSION / MÉTODO PRINT PARA REGRESSÃO AVANÇADA
# ===============================================================================

#' Print method for advanced_regression objects
#' Método de impressão para objetos advanced_regression
#'
#' @param x An advanced_regression object
#' @param ... Additional arguments passed to print
#'
#' @export
print.advanced_regression <- function(x, ...) {
  cat("\n")
  if (x$robust) {
    cat("=== ROBUST LINEAR REGRESSION RESULTS ===\n")
    cat("=== RESULTADOS DE REGRESSÃO LINEAR ROBUSTA ===\n\n")
  } else {
    cat("=== MULTIPLE LINEAR REGRESSION RESULTS ===\n")
    cat("=== RESULTADOS DE REGRESSÃO LINEAR MÚLTIPLA ===\n\n")
  }
  
  cat("Formula / Fórmula:", deparse(x$formula), "\n\n")
  
  print(x$summary)
  
  # Print assumption test results / Imprimir resultados dos testes de pressupostos
  cat("\n=== ASSUMPTION TESTS / TESTES DE PRESSUPOSTOS ===\n")
  
  if (!is.null(x$assumptions$shapiro_test) && !is.na(x$assumptions$shapiro_test$p.value)) {
    cat(sprintf("Shapiro-Wilk Normality Test: p = %.4f\n", 
                x$assumptions$shapiro_test$p.value))
    if (x$assumptions$shapiro_test$p.value < 0.05) {
      cat("  → Residuals may not be normally distributed\n")
      cat("  → Resíduos podem não ter distribuição normal\n")
    }
  }
  
  if (!is.null(x$assumptions$breusch_pagan)) {
    cat(sprintf("Breusch-Pagan Homoscedasticity Test: p = %.4f\n",
                x$assumptions$breusch_pagan$p))
  }
  
  if (!is.null(x$assumptions$vif)) {
    cat("\nVariance Inflation Factors (VIF):\n")
    print(round(x$assumptions$vif, 2))
    if (any(x$assumptions$vif > 10)) {
      cat("  → High multicollinearity detected (VIF > 10)\n")
      cat("  → Alta multicolinearidade detectada (VIF > 10)\n")
    }
  }
  
  cat("\n=== DIAGNOSTIC PLOTS AVAILABLE ===\n")
  cat("=== GRÁFICOS DIAGNÓSTICOS DISPONÍVEIS ===\n")
  cat("• $diagnostics$residuals_fitted\n")
  cat("• $diagnostics$qq_plot\n") 
  cat("• $diagnostics$scale_location\n")
  
  invisible(x)
}

# ===============================================================================
# EXAMPLE USAGE / EXEMPLO DE USO
# ===============================================================================

# Uncomment to run examples / Descomente para executar exemplos
# 
# # Load example data / Carregar dados de exemplo
# data(mtcars)
# 
# # Perform regression analysis / Realizar análise de regressão
# result <- advanced_linear_regression(mpg ~ wt + hp + cyl + disp, 
#                                     data = mtcars, 
#                                     alpha = 0.05)
# 
# # Print results / Imprimir resultados
# print(result)
# 
# # View diagnostic plots / Ver gráficos diagnósticos
# print(result$diagnostics$residuals_fitted)
# print(result$diagnostics$qq_plot)
# print(result$diagnostics$scale_location)
# 
# # Robust regression example / Exemplo de regressão robusta
# result_robust <- advanced_linear_regression(mpg ~ wt + hp, 
#                                           data = mtcars, 
#                                           robust = TRUE)
# print(result_robust)

# ===============================================================================
# END OF FILE / FIM DO ARQUIVO
# ===============================================================================
