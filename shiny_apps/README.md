# Shiny Apps - Advanced Statistical Analysis

Este diretório contém uma coleção de aplicações Shiny interativas para análise estatística avançada. Cada aplicação é projetada para fornecer uma interface de fácil utilização para diferentes aspectos da análise estatística e visualização de dados.

## Aplicações Disponíveis

### 📋 [Multivariate Explorer](./multivariate_explorer/)
Ferramenta abrangente para exploração e análise de dados multivariados.

**Principais funcionalidades:**
- Análise de Componentes Principais (PCA)
- Análise de Agrupamento (Clustering)
- Visualizações multidimensionais interativas
- Matriz de correlação e heatmaps
- Análise discriminante

### 📈 [Regression Analyzer](./regression_analyzer/)
Plataforma completa para análise de regressão linear e diagnósticos de modelo.

**Principais funcionalidades:**
- Modelos de regressão linear simples e múltipla
- Diagnósticos abrangentes de modelo
- Seleção automática de variáveis
- Visualizações interativas de resultados
- Relatórios exportados

### ⏳ [Time Series Dashboard](./time_series_dashboard/)
Dashboard especializado para análise e modelagem de séries temporais.

**Principais funcionalidades:**
- Visualização de séries temporais interativas
- Decomposição de tendência e sazonalidade
- Modelos de previsão (ARIMA, Holt-Winters)
- Detecção de anomalias
- Dashboard em tempo real

## Como Executar

### Pré-requisitos
```r
# Instalar dependências principais
install.packages(c(
  "shiny", "shinydashboard", "DT", "plotly", 
  "corrplot", "car", "broom", "forecast", 
  "dygraphs", "xts", "zoo", "cluster", "factoextra"
))
```

### Executar Aplicação
```r
# Para executar uma aplicação específica:
library(shiny)

# Exemplo: Executar o Multivariate Explorer
runApp("multivariate_explorer")

# Exemplo: Executar o Regression Analyzer  
runApp("regression_analyzer")

# Exemplo: Executar o Time Series Dashboard
runApp("time_series_dashboard")
```

## Estrutura dos Projetos

Cada aplicação segue a estrutura padrão do Shiny:

```
app_name/
├── ui.R          # Interface do usuário
├── server.R      # Lógica do servidor
├── global.R      # Variáveis e funções globais (opcional)
├── www/          # Arquivos estáticos (CSS, JS, imagens)
└── README.md     # Documentação específica
```

## Contribuição

Para contribuir com novas funcionalidades ou correções:

1. Faça fork do projeto
2. Crie uma branch para sua feature
3. Implemente as alterações
4. Teste a aplicação
5. Submeta um pull request

## Suporte

Para dúvidas ou problemas:
- Consulte a documentação de cada aplicação no respectivo README
- Abra uma issue no repositório principal
- Verifique os logs do console R para mensagens de erro
