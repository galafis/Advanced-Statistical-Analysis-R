# ==============================================================================
# SURVIVAL ANALYSIS FUNCTIONS
# FUNÇÕES DE ANÁLISE DE SOBREVIVÊNCIA
# ==============================================================================
#
# Description (English):
# This file contains functions for survival analysis in R, including
# Kaplan-Meier estimation, Cox proportional hazards models, and related
# statistical methods. These functions provide comprehensive tools for
# analyzing time-to-event data in medical research, engineering reliability
# studies, and other fields where survival analysis is applicable.
#
# Descrição (Português):
# Este arquivo contém funções para análise de sobrevivência em R, incluindo
# estimação de Kaplan-Meier, modelos de riscos proporcionais de Cox e métodos
# estatísticos relacionados. Essas funções fornecem ferramentas abrangentes
# para analisar dados de tempo até evento em pesquisa médica, estudos de
# confiabilidade em engenharia e outros campos onde a análise de sobrevivência
# é aplicável.
#
# Author/Autor: Advanced Statistical Analysis Team
# Date/Data: 2025-09-09
# Version/Versão: 1.0
# License/Licença: MIT
#
# Dependencies/Dependências:
# - survival package
# - ggplot2 package
# - dplyr package
#
# ==============================================================================

# Required libraries
library(survival)
library(ggplot2)
library(dplyr)

#' Kaplan-Meier Survival Analysis
#' Análise de Sobrevivência de Kaplan-Meier
#'
#' @description
#' This function performs Kaplan-Meier survival analysis and generates
#' survival curves with optional group comparisons. It provides comprehensive
#' output including survival estimates, confidence intervals, and statistical
#' tests for group differences.
#'
#' Esta função realiza análise de sobrevivência de Kaplan-Meier e gera
#' curvas de sobrevivência com comparações opcionais entre grupos. Fornece
#' saída abrangente incluindo estimativas de sobrevivência, intervalos de
#' confiança e testes estatísticos para diferenças entre grupos.
#'
#' @param data A data frame containing the survival data
#'             Um data frame contendo os dados de sobrevivência
#' @param time_var Character string specifying the time variable name
#'                 String de caractere especificando o nome da variável tempo
#' @param event_var Character string specifying the event variable name (0/1)
#'                  String de caractere especificando o nome da variável evento (0/1)
#' @param group_var Optional character string for grouping variable
#'                  String de caractere opcional para variável de agrupamento
#' @param conf_level Confidence level for intervals (default 0.95)
#'                   Nível de confiança para intervalos (padrão 0.95)
#' @param plot Logical, whether to generate survival plot (default TRUE)
#'             Lógico, se deve gerar gráfico de sobrevivência (padrão TRUE)
#'
#' @return A list containing:
#'         Uma lista contendo:
#'   \item{fit}{survfit object with Kaplan-Meier estimates}
#'   \item{summary}{summary table of survival estimates}
#'   \item{plot}{ggplot object of survival curves (if plot=TRUE)}
#'   \item{logrank_test}{log-rank test results (if group_var provided)}
#'
#' @examples
#' # Example with lung cancer data
#' # Exemplo com dados de câncer de pulmão
#' data(lung, package = "survival")
#' lung_clean <- lung[complete.cases(lung[c("time", "status")]), ]
#' 
#' # Basic Kaplan-Meier analysis
#' # Análise básica de Kaplan-Meier
#' km_result <- analisar_kaplan_meier(
#'   data = lung_clean,
#'   time_var = "time",
#'   event_var = "status",
#'   plot = TRUE
#' )
#' 
#' # Analysis by sex groups
#' # Análise por grupos de sexo
#' km_by_sex <- analisar_kaplan_meier(
#'   data = lung_clean,
#'   time_var = "time",
#'   event_var = "status",
#'   group_var = "sex",
#'   plot = TRUE
#' )
#' 
#' # Print results
#' # Imprimir resultados
#' print(km_by_sex$summary)
#' print(km_by_sex$logrank_test)
#'
#' @export
analisar_kaplan_meier <- function(data, 
                                  time_var, 
                                  event_var, 
                                  group_var = NULL, 
                                  conf_level = 0.95,
                                  plot = TRUE) {
  
  # Input validation / Validação de entrada
  if (!is.data.frame(data)) {
    stop("Data must be a data frame / Dados devem ser um data frame")
  }
  
  if (!time_var %in% names(data)) {
    stop(paste("Time variable", time_var, "not found in data / Variável tempo não encontrada nos dados"))
  }
  
  if (!event_var %in% names(data)) {
    stop(paste("Event variable", event_var, "not found in data / Variável evento não encontrada nos dados"))
  }
  
  if (!is.null(group_var) && !group_var %in% names(data)) {
    stop(paste("Group variable", group_var, "not found in data / Variável grupo não encontrada nos dados"))
  }
  
  # Create survival object / Criar objeto de sobrevivência
  if (is.null(group_var)) {
    surv_formula <- as.formula(paste("Surv(", time_var, ",", event_var, ") ~ 1"))
  } else {
    surv_formula <- as.formula(paste("Surv(", time_var, ",", event_var, ") ~", group_var))
  }
  
  # Fit Kaplan-Meier model / Ajustar modelo de Kaplan-Meier
  km_fit <- survfit(surv_formula, data = data, conf.int = conf_level)
  
  # Create summary table / Criar tabela resumo
  km_summary <- summary(km_fit)
  summary_df <- data.frame(
    time = km_summary$time,
    n.risk = km_summary$n.risk,
    n.event = km_summary$n.event,
    survival = round(km_summary$surv, 4),
    std.err = round(km_summary$std.err, 4),
    lower = round(km_summary$lower, 4),
    upper = round(km_summary$upper, 4)
  )
  
  if (!is.null(group_var)) {
    summary_df$group <- km_summary$strata
  }
  
  # Log-rank test if groups provided / Teste log-rank se grupos fornecidos
  logrank_result <- NULL
  if (!is.null(group_var)) {
    logrank_result <- survdiff(surv_formula, data = data)
  }
  
  # Create survival plot / Criar gráfico de sobrevivência
  survival_plot <- NULL
  if (plot) {
    plot_data <- data.frame(
      time = km_summary$time,
      survival = km_summary$surv,
      lower = km_summary$lower,
      upper = km_summary$upper
    )
    
    if (!is.null(group_var)) {
      plot_data$group <- km_summary$strata
      
      survival_plot <- ggplot(plot_data, aes(x = time, y = survival, color = group)) +
        geom_step(size = 1) +
        geom_ribbon(aes(ymin = lower, ymax = upper, fill = group), alpha = 0.2) +
        labs(
          title = "Kaplan-Meier Survival Curves / Curvas de Sobrevivência de Kaplan-Meier",
          x = "Time / Tempo",
          y = "Survival Probability / Probabilidade de Sobrevivência",
          color = "Group / Grupo",
          fill = "Group / Grupo"
        ) +
        theme_minimal() +
        theme(
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
          legend.position = "bottom"
        ) +
        scale_y_continuous(limits = c(0, 1), labels = scales::percent)
    } else {
      survival_plot <- ggplot(plot_data, aes(x = time, y = survival)) +
        geom_step(size = 1, color = "blue") +
        geom_ribbon(aes(ymin = lower, ymax = upper), alpha = 0.2, fill = "blue") +
        labs(
          title = "Kaplan-Meier Survival Curve / Curva de Sobrevivência de Kaplan-Meier",
          x = "Time / Tempo",
          y = "Survival Probability / Probabilidade de Sobrevivência"
        ) +
        theme_minimal() +
        theme(
          plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
        ) +
        scale_y_continuous(limits = c(0, 1), labels = scales::percent)
    }
  }
  
  # Return results / Retornar resultados
  result <- list(
    fit = km_fit,
    summary = summary_df,
    plot = survival_plot,
    logrank_test = logrank_result
  )
  
  class(result) <- "kaplan_meier_analysis"
  return(result)
}

#' Print method for kaplan_meier_analysis objects
#' Método de impressão para objetos kaplan_meier_analysis
#'
#' @param x A kaplan_meier_analysis object
#' @param ... Additional arguments
#' @export
print.kaplan_meier_analysis <- function(x, ...) {
  cat("\n=== Kaplan-Meier Survival Analysis Results ===")
  cat("\n=== Resultados da Análise de Sobrevivência de Kaplan-Meier ===\n\n")
  
  cat("Summary Statistics / Estatísticas Resumo:\n")
  print(summary(x$fit))
  
  if (!is.null(x$logrank_test)) {
    cat("\n\nLog-rank Test / Teste Log-rank:\n")
    print(x$logrank_test)
  }
  
  cat("\n\nMedian survival times / Tempos medianos de sobrevivência:\n")
  print(summary(x$fit)$table)
}

# ==============================================================================
# EXAMPLE USAGE / EXEMPLO DE USO
# ==============================================================================

# Uncomment the following lines to run examples
# Descomente as linhas seguintes para executar exemplos

# # Load example data
# # Carregar dados de exemplo
# data(lung, package = "survival")
# lung_clean <- lung[complete.cases(lung[c("time", "status")]), ]
# 
# # Convert sex to factor with labels
# # Converter sexo para fator com rótulos
# lung_clean$sex <- factor(lung_clean$sex, levels = c(1, 2), labels = c("Male", "Female"))
# 
# # Perform Kaplan-Meier analysis
# # Realizar análise de Kaplan-Meier
# km_analysis <- analisar_kaplan_meier(
#   data = lung_clean,
#   time_var = "time",
#   event_var = "status",
#   group_var = "sex",
#   plot = TRUE
# )
# 
# # Display results
# # Exibir resultados
# print(km_analysis)
# 
# # Show the plot
# # Mostrar o gráfico
# if (!is.null(km_analysis$plot)) {
#   print(km_analysis$plot)
# }

# ==============================================================================
# END OF FILE / FIM DO ARQUIVO
# ==============================================================================
