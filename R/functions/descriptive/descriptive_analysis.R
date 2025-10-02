# descriptive_analysis.R
# =============================================
# Script de análise descritiva para projetos estatísticos avançados em R
# Desenvolvido por Gabriel Demetrios Lafis
# Última atualização: setembro de 2025
#
# Este arquivo contém funções e exemplos para geração de estatísticas descritivas
# e visualizações básicas para compreensão exploratória dos dados.

library(dplyr)
library(ggplot2)

# Função básica: resumo estatístico de um dataframe
describe_data <- function(df) {
  summary_stats <- df %>%
    summarise_all(list(
      min = min,
      max = max,
      mean = mean,
      sd = sd
    ), na.rm = TRUE)
  return(summary_stats)
}

# Função para criar histogramas automáticos das colunas numéricas
plot_histograms <- function(df) {
  num_cols <- sapply(df, is.numeric)
  for (col in names(df)[num_cols]) {
    print(
      ggplot(df, aes_string(x = col)) +
        geom_histogram(fill = "steelblue", alpha = 0.7, bins = 30) +
        labs(title = paste("Histograma de", col), x = col)
    )
  }
}

# Exemplos de uso e comentários extras podem ser colocados ao final.
