# =============================================================================
# MULTIVARIATE ANALYSIS / ANÁLISE MULTIVARIADA
# =============================================================================
# Description: Advanced multivariate statistical analysis functions
# Descrição: Funções avançadas para análise estatística multivariada
# Author: Generated for Advanced Statistical Analysis R Package
# Date: 2025-09-09
# =============================================================================

#' Principal Component Analysis with comprehensive output
#' Análise de Componentes Principais com saída abrangente
#'
#' @description Performs PCA with detailed statistical output and visualizations
#' @description Realiza PCA com saída estatística detalhada e visualizações
#' @param data numeric data frame or matrix
#' @param scale logical, whether to scale variables (default: TRUE)
#' @param center logical, whether to center variables (default: TRUE)
#' @param plot logical, whether to generate plots (default: TRUE)
#' @return list containing PCA results, summary statistics, and plots
#' @export
#' @examples
#' # English example
#' data(iris)
#' pca_result <- robust_pca(iris[,1:4], plot = TRUE)
#' print(pca_result$summary)
#' 
#' # Exemplo em português
#' dados <- iris[,1:4]
#' resultado_pca <- robust_pca(dados, plot = TRUE)
#' print(resultado_pca$summary)
robust_pca <- function(data, scale = TRUE, center = TRUE, plot = TRUE) {
  # Input validation / Validação de entrada
  if (!is.data.frame(data) && !is.matrix(data)) {
    stop("Data must be a data frame or matrix / Dados devem ser data frame ou matriz")
  }
  
  if (!is.numeric(as.matrix(data))) {
    stop("Data must be numeric / Dados devem ser numéricos")
  }
  
  # Remove missing values / Remover valores ausentes
  data_clean <- na.omit(data)
  if (nrow(data_clean) < nrow(data)) {
    warning(paste("Removed", nrow(data) - nrow(data_clean), "rows with missing values /",
                  "Removidas", nrow(data) - nrow(data_clean), "linhas com valores ausentes"))
  }
  
  # Perform PCA / Realizar PCA
  pca_result <- prcomp(data_clean, scale. = scale, center = center)
  
  # Calculate summary statistics / Calcular estatísticas resumo
  variance_explained <- pca_result$sdev^2 / sum(pca_result$sdev^2)
  cumulative_variance <- cumsum(variance_explained)
  
  # Create summary table / Criar tabela resumo
  summary_table <- data.frame(
    Component = paste0("PC", 1:length(pca_result$sdev)),
    Standard_Deviation = pca_result$sdev,
    Proportion_Variance = variance_explained,
    Cumulative_Proportion = cumulative_variance
  )
  
  # Generate plots if requested / Gerar gráficos se solicitado
  plots <- NULL
  if (plot) {
    # Scree plot
    par(mfrow = c(2, 2))
    
    # Plot 1: Scree plot
    plot(1:length(pca_result$sdev), pca_result$sdev^2, 
         type = "b", xlab = "Principal Component", ylab = "Variance",
         main = "Scree Plot / Gráfico Scree")
    
    # Plot 2: Cumulative variance
    plot(1:length(cumulative_variance), cumulative_variance, 
         type = "b", xlab = "Principal Component", ylab = "Cumulative Proportion",
         main = "Cumulative Variance / Variância Cumulativa")
    
    # Plot 3: Biplot if 2 or more components
    if (ncol(pca_result$x) >= 2) {
      biplot(pca_result, main = "PCA Biplot")
    }
    
    # Plot 4: Loadings heatmap
    if (ncol(pca_result$rotation) >= 2) {
      heatmap(pca_result$rotation[, 1:min(4, ncol(pca_result$rotation))], 
              main = "Loadings Heatmap / Mapa de Cargas")
    }
    
    par(mfrow = c(1, 1))
  }
  
  # Return comprehensive results / Retornar resultados abrangentes
  result <- list(
    pca = pca_result,
    summary = summary_table,
    variance_explained = variance_explained,
    cumulative_variance = cumulative_variance,
    n_observations = nrow(data_clean),
    n_variables = ncol(data_clean)
  )
  
  class(result) <- "robust_pca"
  return(result)
}

# Example usage / Exemplo de uso
if (FALSE) {
  # Load required packages / Carregar pacotes necessários
  # install.packages(c("datasets"))
  
  # English example with iris dataset
  data(iris)
  iris_numeric <- iris[, 1:4]
  
  # Perform PCA
  pca_iris <- robust_pca(iris_numeric, scale = TRUE, plot = TRUE)
  
  # View results
  print(pca_iris$summary)
  cat("\nFirst two principal components explain", 
      round(pca_iris$cumulative_variance[2] * 100, 1), "% of variance\n")
  
  # Exemplo em português com dataset mtcars
  dados_carros <- mtcars[, c("mpg", "hp", "wt", "qsec")]
  
  # Realizar PCA
  pca_carros <- robust_pca(dados_carros, scale = TRUE, plot = TRUE)
  
  # Visualizar resultados
  print(pca_carros$summary)
  cat("\nOs dois primeiros componentes explicam", 
      round(pca_carros$cumulative_variance[2] * 100, 1), "% da variância\n")
}
