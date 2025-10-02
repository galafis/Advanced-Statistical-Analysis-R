# hypothesis_testing.R
# =============================================
# Script de testes de hipóteses para análise estatística avançada em R
# Desenvolvido por Gabriel Demetrios Lafis
# Última atualização: setembro de 2025
#
# Este arquivo reúne funções para realizar testes estatísticos clássicos
# como t-test, ANOVA, chi-squared, entre outros.

library(stats)

# Função para teste t entre dois grupos
run_t_test <- function(df, col, group) {
  t_res <- t.test(df[[col]] ~ df[[group]])
  return(t_res)
}

# Função para ANOVA
run_anova <- function(df, response, group) {
  aov_res <- aov(df[[response]] ~ as.factor(df[[group]]), data = df)
  return(summary(aov_res))
}

# Função para teste qui-quadrado em tabelas de contingência
run_chisq_test <- function(table) {
  chisq_res <- chisq.test(table)
  return(chisq_res)
}

# Comentários adicionais sobre parametrização podem ser incluídos aqui.
