# =============================================================================
# VISUALIZATION.R - ADVANCED STATISTICAL ANALYSIS
# =============================================================================
# EN: Advanced visualization functions for statistical analysis
# PT: Funções avançadas de visualização para análise estatística
#
# Author/Autor: Advanced Statistical Analysis R Project
# Date/Data: September 2025
# Version/Versão: 1.0
# =============================================================================

# Required Libraries / Bibliotecas Necessárias
library(ggplot2)
library(dplyr)

#' Linear Regression Scatterplot / Gráfico de Dispersão com Regressão Linear
#'
#' EN: Creates a scatterplot with linear regression line and confidence interval
#' PT: Cria um gráfico de dispersão com linha de regressão linear e intervalo de confiança
#'
#' @param data A data frame containing the variables / Data frame contendo as variáveis
#' @param x_var Character string with x variable name / String com nome da variável x
#' @param y_var Character string with y variable name / String com nome da variável y
#' @param title Plot title / Título do gráfico
#' @param x_label X-axis label / Rótulo do eixo x
#' @param y_label Y-axis label / Rótulo do eixo y
#' @param point_color Color of points / Cor dos pontos
#' @param line_color Color of regression line / Cor da linha de regressão
#' @param show_equation Logical, show equation on plot / Lógico, mostrar equação no gráfico
#'
#' @return A ggplot object / Objeto ggplot
#'
#' @examples
#' # Example usage / Exemplo de uso:
#' data(mtcars)
#' plot_regressao(mtcars, "wt", "mpg", 
#'                title = "Weight vs MPG",
#'                x_label = "Weight (1000 lbs)",
#'                y_label = "Miles per Gallon")
#'
#' @export
plot_regressao <- function(data, x_var, y_var, 
                          title = "Linear Regression Plot",
                          x_label = x_var,
                          y_label = y_var,
                          point_color = "steelblue",
                          line_color = "red",
                          show_equation = TRUE) {
  
  # Input validation / Validação de entrada
  if (!is.data.frame(data)) {
    stop("EN: 'data' must be a data frame / PT: 'data' deve ser um data frame")
  }
  
  if (!(x_var %in% names(data))) {
    stop(paste("EN: Variable", x_var, "not found in data / PT: Variável", x_var, "não encontrada nos dados"))
  }
  
  if (!(y_var %in% names(data))) {
    stop(paste("EN: Variable", y_var, "not found in data / PT: Variável", y_var, "não encontrada nos dados"))
  }
  
  # Calculate regression / Calcular regressão
  formula_reg <- as.formula(paste(y_var, "~", x_var))
  model <- lm(formula_reg, data = data)
  
  # Create base plot / Criar gráfico base
  p <- ggplot(data, aes_string(x = x_var, y = y_var)) +
    geom_point(color = point_color, alpha = 0.7, size = 2) +
    geom_smooth(method = "lm", se = TRUE, color = line_color, 
                fill = "lightgray", alpha = 0.3) +
    labs(title = title,
         x = x_label,
         y = y_label) +
    theme_minimal() +
    theme(plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
          axis.text = element_text(size = 11),
          axis.title = element_text(size = 12))
  
  # Add equation if requested / Adicionar equação se solicitado
  if (show_equation) {
    # Extract coefficients / Extrair coeficientes
    intercept <- round(coef(model)[1], 3)
    slope <- round(coef(model)[2], 3)
    r_squared <- round(summary(model)$r.squared, 3)
    
    # Create equation text / Criar texto da equação
    equation <- paste0("y = ", slope, "x + ", intercept, "\n", "R² = ", r_squared)
    
    # Add equation to plot / Adicionar equação ao gráfico
    p <- p + annotate("text", 
                     x = Inf, y = Inf, 
                     label = equation,
                     hjust = 1.1, vjust = 1.1,
                     size = 4,
                     color = "black",
                     fontface = "italic")
  }
  
  return(p)
}

# =============================================================================
# USAGE EXAMPLE / EXEMPLO DE USO
# =============================================================================

# Example 1: Basic usage with mtcars dataset
# Exemplo 1: Uso básico com dataset mtcars
if (FALSE) {
  # Load data / Carregar dados
  data(mtcars)
  
  # Create regression plot / Criar gráfico de regressão
  p1 <- plot_regressao(mtcars, "wt", "mpg", 
                       title = "Vehicle Weight vs Fuel Efficiency",
                       x_label = "Weight (1000 lbs)",
                       y_label = "Miles per Gallon (MPG)")
  
  print(p1)
  
  # Example 2: Customized colors
  # Exemplo 2: Cores personalizadas
  p2 <- plot_regressao(mtcars, "hp", "mpg",
                       title = "Horsepower vs Fuel Efficiency", 
                       x_label = "Horsepower",
                       y_label = "Miles per Gallon (MPG)",
                       point_color = "darkgreen",
                       line_color = "orange")
  
  print(p2)
  
  # Example 3: Without equation display
  # Exemplo 3: Sem exibição da equação
  p3 <- plot_regressao(mtcars, "disp", "mpg",
                       title = "Engine Displacement vs Fuel Efficiency",
                       x_label = "Displacement (cu.in.)",
                       y_label = "Miles per Gallon (MPG)",
                       show_equation = FALSE)
  
  print(p3)
}

# =============================================================================
# END OF FILE / FIM DO ARQUIVO
# =============================================================================
