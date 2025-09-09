# Regression Analyzer

Esta aplicação Shiny fornece uma interface interativa para análise de regressão abrangente.

## Funcionalidades

- **Análise de Regressão Linear**: Modelos de regressão linear simples e múltipla
- **Diagnósticos de Modelo**: Gráficos de resíduos, testes de normalidade e homocedasticidade
- **Seleção de Variáveis**: Métodos automáticos para seleção de variáveis (stepwise, forward, backward)
- **Visualizações Interativas**: Gráficos de dispersão, matriz de correlação e plots de diagnóstico
- **Relatórios**: Exportação de resultados em formato PDF ou HTML

## Como Usar

1. Carregue seus dados (CSV, Excel ou RData)
2. Selecione as variáveis dependente e independentes
3. Execute a análise de regressão
4. Explore os diagnósticos do modelo
5. Exporte os resultados

## Dependências

- shiny
- shinydashboard
- DT
- plotly
- corrplot
- car
- broom
