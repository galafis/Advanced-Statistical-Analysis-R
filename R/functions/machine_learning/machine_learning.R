# =============================================================================
# Machine Learning Functions / Funções de Machine Learning
# =============================================================================
# Description: Advanced machine learning functions for statistical analysis
# Descrição: Funções avançadas de machine learning para análise estatística
# 
# Author: Advanced Statistical Analysis R Project
# Autor: Projeto de Análise Estatística Avançada R
# 
# Created: September 2025
# Criado: Setembro 2025
# =============================================================================

# Required libraries / Bibliotecas necessárias
library(randomForest)
library(caret)
library(dplyr)

#' Train Random Forest Model
#' Treinar Modelo Random Forest
#' 
#' @description
#' This function trains a robust Random Forest model with cross-validation
#' and feature importance analysis.
#' Esta função treina um modelo Random Forest robusto com validação cruzada
#' e análise de importância das características.
#' 
#' @param data A data frame containing the dataset / Data frame contendo o dataset
#' @param target_col Character string with target variable name / String com nome da variável alvo
#' @param test_size Proportion of data for testing (default: 0.2) / Proporção dos dados para teste (padrão: 0.2)
#' @param ntree Number of trees (default: 500) / Número de árvores (padrão: 500)
#' @param mtry Number of variables at each split (default: auto) / Número de variáveis em cada divisão (padrão: auto)
#' @param seed Random seed for reproducibility / Semente aleatória para reprodutibilidade
#' 
#' @return A list containing model, predictions, and performance metrics
#'         Lista contendo modelo, previsões e métricas de desempenho
#' 
#' @examples
#' # Load iris dataset / Carregar dataset iris
#' data(iris)
#' result <- treinar_random_forest(iris, "Species", test_size = 0.3, seed = 42)
#' print(result$performance)
#' 
#' @export
treinar_random_forest <- function(data, target_col, test_size = 0.2, 
                                   ntree = 500, mtry = NULL, seed = 123) {
  
  # Input validation / Validação de entrada
  if (!is.data.frame(data)) {
    stop("Data must be a data frame / Dados devem ser um data frame")
  }
  
  if (!target_col %in% names(data)) {
    stop(paste("Target column", target_col, "not found in data / Coluna alvo", 
               target_col, "não encontrada nos dados"))
  }
  
  if (test_size <= 0 || test_size >= 1) {
    stop("test_size must be between 0 and 1 / test_size deve estar entre 0 e 1")
  }
  
  # Set seed for reproducibility / Definir semente para reprodutibilidade
  set.seed(seed)
  
  # Remove rows with missing values / Remover linhas com valores ausentes
  data_clean <- data[complete.cases(data), ]
  
  if (nrow(data_clean) < nrow(data)) {
    message(paste("Removed", nrow(data) - nrow(data_clean), 
                  "rows with missing values / Removidas", 
                  nrow(data) - nrow(data_clean), 
                  "linhas com valores ausentes"))
  }
  
  # Split data into training and testing / Dividir dados em treino e teste
  train_index <- sample(nrow(data_clean), 
                        size = floor((1 - test_size) * nrow(data_clean)))
  train_data <- data_clean[train_index, ]
  test_data <- data_clean[-train_index, ]
  
  # Prepare formula / Preparar fórmula
  formula_str <- paste(target_col, "~ .")
  rf_formula <- as.formula(formula_str)
  
  # Set mtry if not provided / Definir mtry se não fornecido
  if (is.null(mtry)) {
    if (is.factor(data_clean[[target_col]])) {
      # Classification / Classificação
      mtry <- floor(sqrt(ncol(data_clean) - 1))
    } else {
      # Regression / Regressão
      mtry <- floor((ncol(data_clean) - 1) / 3)
    }
  }
  
  # Train Random Forest model / Treinar modelo Random Forest
  message("Training Random Forest model... / Treinando modelo Random Forest...")
  
  rf_model <- randomForest(
    formula = rf_formula,
    data = train_data,
    ntree = ntree,
    mtry = mtry,
    importance = TRUE,
    na.action = na.omit
  )
  
  # Make predictions / Fazer previsões
  train_predictions <- predict(rf_model, train_data)
  test_predictions <- predict(rf_model, test_data)
  
  # Calculate performance metrics / Calcular métricas de desempenho
  if (is.factor(data_clean[[target_col]])) {
    # Classification metrics / Métricas de classificação
    train_accuracy <- mean(train_predictions == train_data[[target_col]])
    test_accuracy <- mean(test_predictions == test_data[[target_col]])
    
    # Confusion matrix / Matriz de confusão
    conf_matrix <- table(Predicted = test_predictions, 
                        Actual = test_data[[target_col]])
    
    performance <- list(
      type = "classification",
      train_accuracy = round(train_accuracy, 4),
      test_accuracy = round(test_accuracy, 4),
      confusion_matrix = conf_matrix,
      oob_error = round(rf_model$err.rate[ntree, "OOB"], 4)
    )
    
  } else {
    # Regression metrics / Métricas de regressão
    train_rmse <- sqrt(mean((train_predictions - train_data[[target_col]])^2))
    test_rmse <- sqrt(mean((test_predictions - test_data[[target_col]])^2))
    
    train_r2 <- cor(train_predictions, train_data[[target_col]])^2
    test_r2 <- cor(test_predictions, test_data[[target_col]])^2
    
    performance <- list(
      type = "regression",
      train_rmse = round(train_rmse, 4),
      test_rmse = round(test_rmse, 4),
      train_r2 = round(train_r2, 4),
      test_r2 = round(test_r2, 4),
      mse = round(mean(rf_model$mse), 4)
    )
  }
  
  # Feature importance / Importância das características
  importance_df <- data.frame(
    Variable = rownames(rf_model$importance),
    rf_model$importance
  ) %>%
    arrange(desc(MeanDecreaseGini))
  
  # Return results / Retornar resultados
  result <- list(
    model = rf_model,
    train_data = train_data,
    test_data = test_data,
    train_predictions = train_predictions,
    test_predictions = test_predictions,
    performance = performance,
    feature_importance = importance_df,
    parameters = list(
      ntree = ntree,
      mtry = mtry,
      test_size = test_size,
      seed = seed
    )
  )
  
  # Print summary / Imprimir resumo
  message("\n=== Random Forest Model Summary / Resumo do Modelo Random Forest ===")
  message(paste("Number of trees / Número de árvores:", ntree))
  message(paste("Variables per split / Variáveis por divisão:", mtry))
  message(paste("Training samples / Amostras de treino:", nrow(train_data)))
  message(paste("Testing samples / Amostras de teste:", nrow(test_data)))
  
  if (performance$type == "classification") {
    message(paste("Test Accuracy / Acurácia de Teste:", 
                  round(performance$test_accuracy * 100, 2), "%"))
  } else {
    message(paste("Test R² / R² de Teste:", round(performance$test_r2, 4)))
    message(paste("Test RMSE / RMSE de Teste:", round(performance$test_rmse, 4)))
  }
  
  return(result)
}

# =============================================================================
# Usage Examples / Exemplos de Uso
# =============================================================================

# Example 1: Classification with Iris dataset
# Exemplo 1: Classificação com dataset Iris
if (FALSE) {
  # Load data / Carregar dados
  data(iris)
  
  # Train model / Treinar modelo
  iris_result <- treinar_random_forest(
    data = iris,
    target_col = "Species",
    test_size = 0.3,
    ntree = 300,
    seed = 42
  )
  
  # View results / Ver resultados
  print(iris_result$performance)
  print(iris_result$feature_importance)
  
  # Plot feature importance / Plotar importância das características
  barplot(iris_result$feature_importance$MeanDecreaseGini,
          names.arg = iris_result$feature_importance$Variable,
          main = "Feature Importance / Importância das Características",
          las = 2)
}

# Example 2: Regression with mtcars dataset
# Exemplo 2: Regressão com dataset mtcars
if (FALSE) {
  # Load data / Carregar dados
  data(mtcars)
  
  # Train model for MPG prediction / Treinar modelo para predição de MPG
  mtcars_result <- treinar_random_forest(
    data = mtcars,
    target_col = "mpg",
    test_size = 0.25,
    ntree = 500,
    seed = 123
  )
  
  # View results / Ver resultados
  print(mtcars_result$performance)
  
  # Plot predictions vs actual / Plotar previsões vs real
  plot(mtcars_result$test_data$mpg, 
       mtcars_result$test_predictions,
       xlab = "Actual MPG / MPG Real",
       ylab = "Predicted MPG / MPG Predito",
       main = "Random Forest Predictions / Previsões Random Forest")
  abline(0, 1, col = "red", lty = 2)
}

# =============================================================================
# Additional Utility Functions / Funções Utilitárias Adicionais
# =============================================================================

#' Plot Random Forest Results
#' Plotar Resultados do Random Forest
#' 
#' @param rf_result Result from treinar_random_forest function
#'                  Resultado da função treinar_random_forest
#' @param type Type of plot: "importance", "error", or "predictions"
#'             Tipo de gráfico: "importance", "error", ou "predictions"
#' 
plot_rf_results <- function(rf_result, type = "importance") {
  
  if (type == "importance") {
    # Feature importance plot / Gráfico de importância das características
    barplot(rf_result$feature_importance$MeanDecreaseGini,
            names.arg = rf_result$feature_importance$Variable,
            main = "Feature Importance / Importância das Características",
            xlab = "Variables / Variáveis",
            ylab = "Mean Decrease Gini",
            las = 2,
            col = "steelblue")
            
  } else if (type == "error") {
    # Error plot / Gráfico de erro
    plot(rf_result$model,
         main = "Random Forest Error Rate / Taxa de Erro Random Forest")
         
  } else if (type == "predictions" && rf_result$performance$type == "regression") {
    # Predictions vs actual for regression / Previsões vs real para regressão
    target_col <- names(rf_result$test_data)[sapply(rf_result$test_data, 
                                                   function(x) !is.factor(x))][1]
    
    plot(rf_result$test_data[[target_col]], 
         rf_result$test_predictions,
         xlab = "Actual Values / Valores Reais",
         ylab = "Predicted Values / Valores Preditos",
         main = "Predictions vs Actual / Previsões vs Real",
         col = "darkgreen",
         pch = 19)
    abline(0, 1, col = "red", lty = 2, lwd = 2)
  }
}

# End of file / Fim do arquivo
