# =============================================================================
# Análise Categórica / Categorical Analysis
# =============================================================================
# 
# Descrição (PT-BR): Este script contém funções para análise estatística de 
# dados categóricos, incluindo testes qui-quadrado e análises de associação.
#
# Description (EN): This script contains functions for statistical analysis of 
# categorical data, including chi-square tests and association analyses.
#
# Autor/Author: Advanced Statistical Analysis R Project
# Data/Date: September 2025
# Versão/Version: 1.0
# =============================================================================

#' Teste Qui-Quadrado de Independência
#' Chi-Square Test of Independence
#'
#' @description
#' (PT-BR) Realiza teste qui-quadrado de independência entre duas variáveis categóricas,
#' incluindo verificação de pressupostos e interpretação dos resultados.
#'
#' (EN) Performs chi-square test of independence between two categorical variables,
#' including assumption checking and result interpretation.
#'
#' @param var1 Primeira variável categórica (vetor ou fator)
#'             First categorical variable (vector or factor)
#' @param var2 Segunda variável categórica (vetor ou fator)
#'             Second categorical variable (vector or factor)
#' @param alpha Nível de significância (padrão: 0.05)
#'              Significance level (default: 0.05)
#' @param mostrar_detalhes Mostrar análise detalhada (padrão: TRUE)
#'                        Show detailed analysis (default: TRUE)
#'
#' @return Lista com resultados do teste e estatísticas descritivas
#'         List with test results and descriptive statistics
#'
#' @examples
#' # Exemplo básico / Basic example
#' genero <- c(rep("M", 50), rep("F", 45))
#' preferencia <- c(rep("A", 25), rep("B", 25), rep("A", 20), rep("B", 25))
#' resultado <- teste_quiquadrado(genero, preferencia)
#'
#' @export
teste_quiquadrado <- function(var1, var2, alpha = 0.05, mostrar_detalhes = TRUE) {
  
  # Verificações iniciais / Initial checks
  if (length(var1) != length(var2)) {
    stop("As variáveis devem ter o mesmo comprimento / Variables must have the same length")
  }
  
  if (any(is.na(var1)) || any(is.na(var2))) {
    warning("Valores NA encontrados e serão removidos / NA values found and will be removed")
    indices_validos <- !is.na(var1) & !is.na(var2)
    var1 <- var1[indices_validos]
    var2 <- var2[indices_validos]
  }
  
  # Criar tabela de contingência / Create contingency table
  tabela_contingencia <- table(var1, var2)
  
  # Verificar pressupostos / Check assumptions
  freq_esperadas <- chisq.test(tabela_contingencia)$expected
  pressuposto_ok <- all(freq_esperadas >= 5)
  
  if (!pressuposto_ok && mostrar_detalhes) {
    cat("\n⚠️ ATENÇÃO / WARNING: Algumas células têm frequência esperada < 5\n")
    cat("Some cells have expected frequency < 5\n")
  }
  
  # Realizar teste qui-quadrado / Perform chi-square test
  teste <- chisq.test(tabela_contingencia)
  
  # Calcular tamanho do efeito (V de Cramér) / Calculate effect size (Cramer's V)
  n <- sum(tabela_contingencia)
  cramers_v <- sqrt(teste$statistic / (n * (min(dim(tabela_contingencia)) - 1)))
  
  # Interpretação do resultado / Result interpretation
  significativo <- teste$p.value < alpha
  interpretacao_pt <- ifelse(significativo, 
                           "Há evidência de associação entre as variáveis",
                           "Não há evidência suficiente de associação")
  interpretacao_en <- ifelse(significativo,
                           "There is evidence of association between variables",
                           "There is insufficient evidence of association")
  
  # Mostrar resultados detalhados / Show detailed results
  if (mostrar_detalhes) {
    cat("\n", rep("=", 60), "\n")
    cat("TESTE QUI-QUADRADO DE INDEPENDÊNCIA / CHI-SQUARE TEST OF INDEPENDENCE\n")
    cat(rep("=", 60), "\n\n")
    
    cat("Tabela de Contingência / Contingency Table:\n")
    print(tabela_contingencia)
    
    cat("\nFrequências Esperadas / Expected Frequencies:\n")
    print(round(freq_esperadas, 2))
    
    cat("\nResultados do Teste / Test Results:\n")
    cat(sprintf("χ² = %.4f\n", teste$statistic))
    cat(sprintf("gl / df = %d\n", teste$parameter))
    cat(sprintf("p-valor / p-value = %.6f\n", teste$p.value))
    cat(sprintf("V de Cramér / Cramer's V = %.4f\n", cramers_v))
    
    cat("\nInterpretação / Interpretation:\n")
    cat(sprintf("(PT-BR): %s (α = %.2f)\n", interpretacao_pt, alpha))
    cat(sprintf("(EN): %s (α = %.2f)\n", interpretacao_en, alpha))
    
    # Interpretação do tamanho do efeito / Effect size interpretation
    cat("\nTamanho do Efeito / Effect Size:\n")
    if (cramers_v < 0.1) {
      cat("Efeito pequeno / Small effect\n")
    } else if (cramers_v < 0.3) {
      cat("Efeito médio / Medium effect\n")
    } else {
      cat("Efeito grande / Large effect\n")
    }
  }
  
  # Retornar resultados / Return results
  resultados <- list(
    tabela_contingencia = tabela_contingencia,
    teste_chisq = teste,
    cramers_v = as.numeric(cramers_v),
    significativo = significativo,
    pressuposto_atendido = pressuposto_ok,
    interpretacao_pt = interpretacao_pt,
    interpretacao_en = interpretacao_en,
    alpha = alpha
  )
  
  return(resultados)
}

# =============================================================================
# EXEMPLO DE USO REAL / REAL USAGE EXAMPLE
# =============================================================================

# Dados simulados de uma pesquisa de satisfação por departamento
# Simulated data from a satisfaction survey by department
if (FALSE) { # Bloco não executado automaticamente / Block not executed automatically
  
  # Criar dados de exemplo / Create example data
  set.seed(123)
  n_respondentes <- 200
  
  # Departamentos / Departments
  departamentos <- sample(c("Vendas", "Marketing", "TI", "RH"), 
                         n_respondentes, replace = TRUE,
                         prob = c(0.3, 0.25, 0.25, 0.2))
  
  # Níveis de satisfação com diferentes probabilidades por departamento
  # Satisfaction levels with different probabilities by department
  satisfacao <- character(n_respondentes)
  
  for (i in 1:n_respondentes) {
    if (departamentos[i] == "Vendas") {
      satisfacao[i] <- sample(c("Baixa", "Média", "Alta"), 1, prob = c(0.4, 0.4, 0.2))
    } else if (departamentos[i] == "Marketing") {
      satisfacao[i] <- sample(c("Baixa", "Média", "Alta"), 1, prob = c(0.2, 0.5, 0.3))
    } else if (departamentos[i] == "TI") {
      satisfacao[i] <- sample(c("Baixa", "Média", "Alta"), 1, prob = c(0.1, 0.4, 0.5))
    } else { # RH
      satisfacao[i] <- sample(c("Baixa", "Média", "Alta"), 1, prob = c(0.3, 0.3, 0.4))
    }
  }
  
  # Executar análise / Run analysis
  cat("\n🔍 ANÁLISE DE SATISFAÇÃO POR DEPARTAMENTO\n")
  cat("🔍 SATISFACTION ANALYSIS BY DEPARTMENT\n\n")
  
  resultado_pesquisa <- teste_quiquadrado(departamentos, satisfacao, alpha = 0.05)
  
  # Análise adicional: proporções por grupo / Additional analysis: proportions by group
  cat("\nProporções por Departamento / Proportions by Department:\n")
  prop_table <- prop.table(table(departamentos, satisfacao), margin = 1)
  print(round(prop_table, 3))
  
  # Gráfico simples (se disponível) / Simple plot (if available)
  if (require(graphics, quietly = TRUE)) {
    cat("\nGerando visualização... / Generating visualization...\n")
    barplot(table(departamentos, satisfacao), 
            main = "Satisfação por Departamento / Satisfaction by Department",
            xlab = "Nível de Satisfação / Satisfaction Level",
            ylab = "Frequência / Frequency",
            legend = TRUE,
            col = c("lightcoral", "lightblue", "lightgreen", "lightyellow"))
  }
}

# Fim do arquivo / End of file
