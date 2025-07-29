# Advanced Statistical Analysis R

![R](https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white)
![RStudio](https://img.shields.io/badge/RStudio-75AADB?style=flat&logo=rstudio&logoColor=white)
![ggplot2](https://img.shields.io/badge/ggplot2-276DC3?style=flat&logo=r&logoColor=white)
![dplyr](https://img.shields.io/badge/dplyr-276DC3?style=flat&logo=r&logoColor=white)
![tidyr](https://img.shields.io/badge/tidyr-276DC3?style=flat&logo=r&logoColor=white)
![plotly](https://img.shields.io/badge/Plotly-3F4F75?style=flat&logo=plotly&logoColor=white)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

Plataforma avançada de análise estatística e visualização de dados desenvolvida em R, oferecendo implementações abrangentes de métodos estatísticos modernos, modelagem preditiva, análise multivariada e visualizações interativas para pesquisa científica e análise de dados empresariais.

## 🎯 Visão Geral

Sistema completo de análise estatística que implementa metodologias avançadas incluindo análise multivariada, modelagem estatística, testes de hipóteses, análise de regressão, séries temporais e machine learning estatístico, com foco em rigor científico e aplicabilidade prática.

### ✨ Características Principais

- **📊 Análise Multivariada**: PCA, Factor Analysis, Cluster Analysis, MANOVA
- **📈 Modelagem Estatística**: Regressão Linear/Logística, GLM, Mixed Models
- **🔍 Testes de Hipóteses**: Paramétricos e não-paramétricos, múltiplas comparações
- **⏱️ Séries Temporais**: ARIMA, Decomposição, Forecasting, Análise Espectral
- **🤖 Machine Learning Estatístico**: Random Forest, SVM, Ensemble Methods
- **📋 Análise de Dados Categóricos**: Tabelas de contingência, Log-linear models
- **🎛️ Visualizações Interativas**: Plotly, Shiny dashboards, ggplot2 avançado

## 🛠️ Stack Tecnológico

### Core Statistical Packages
- **R 4.3+**: Linguagem estatística principal
- **stats**: Funções estatísticas base
- **MASS**: Estatística aplicada moderna
- **car**: Análise de regressão avançada

### Data Manipulation & Visualization
- **dplyr**: Manipulação de dados
- **tidyr**: Organização de dados
- **ggplot2**: Visualizações estatísticas
- **plotly**: Gráficos interativos

### Advanced Statistical Methods
- **psych**: Análise psicométrica e multivariada
- **cluster**: Análise de agrupamentos
- **survival**: Análise de sobrevivência
- **forecast**: Análise de séries temporais
- **randomForest**: Random Forest
- **e1071**: SVM e métodos de ML

### Specialized Analysis
- **vegan**: Análise de comunidades ecológicas
- **lavaan**: Modelagem de equações estruturais
- **nlme**: Modelos lineares mistos não-lineares
- **mgcv**: Modelos aditivos generalizados

## 📁 Estrutura do Projeto

```
Advanced-Statistical-Analysis-R/
├── R/                              # Scripts R principais
│   ├── data_preprocessing.R        # Pré-processamento de dados
│   ├── descriptive_analysis.R     # Análise descritiva
│   ├── hypothesis_testing.R       # Testes de hipóteses
│   ├── regression_analysis.R      # Análise de regressão
│   ├── multivariate_analysis.R    # Análise multivariada
│   ├── time_series_analysis.R     # Análise de séries temporais
│   ├── machine_learning.R         # Machine learning estatístico
│   ├── categorical_analysis.R     # Análise de dados categóricos
│   ├── survival_analysis.R        # Análise de sobrevivência
│   └── visualization.R            # Visualizações avançadas
├── data/                           # Dados de entrada
│   ├── raw/                        # Dados brutos
│   ├── processed/                  # Dados processados
│   └── examples/                   # Datasets de exemplo
├── outputs/                        # Resultados gerados
│   ├── figures/                    # Gráficos e visualizações
│   ├── tables/                     # Tabelas estatísticas
│   ├── models/                     # Modelos salvos
│   └── reports/                    # Relatórios estatísticos
├── shiny_apps/                     # Aplicações Shiny
│   ├── multivariate_explorer/      # Explorador multivariado
│   ├── regression_analyzer/        # Analisador de regressão
│   └── time_series_dashboard/      # Dashboard de séries temporais
├── functions/                      # Funções customizadas
│   ├── statistical_tests.R        # Testes estatísticos customizados
│   ├── plotting_functions.R       # Funções de plotagem
│   └── utility_functions.R        # Funções utilitárias
├── tests/                          # Testes automatizados
├── docs/                           # Documentação
├── statistical_analysis.R         # Script principal
└── README.md                       # Documentação
```

## 🚀 Quick Start

### Pré-requisitos

- R 4.3 ou superior
- RStudio (recomendado)
- Rtools (Windows) ou ferramentas de desenvolvimento (Mac/Linux)

### Instalação

1. **Clone o repositório:**
```bash
git clone https://github.com/galafis/Advanced-Statistical-Analysis-R.git
cd Advanced-Statistical-Analysis-R
```

2. **Instale as dependências:**
```r
# Instalar pacotes necessários
install.packages(c(
  "dplyr", "ggplot2", "tidyr", "plotly", "shiny",
  "psych", "cluster", "survival", "forecast", "randomForest",
  "e1071", "car", "MASS", "vegan", "lavaan", "nlme", "mgcv"
))
```

3. **Execute a análise:**
```r
# Carregar e executar análise principal
source("statistical_analysis.R")
```

4. **Explore os dashboards:**
```r
# Executar aplicação Shiny multivariada
shiny::runApp("shiny_apps/multivariate_explorer/")
```

## 📊 Funcionalidades Detalhadas

### 📈 Análise Multivariada

```r
# Análise de Componentes Principais (PCA)
perform_pca_analysis <- function(data, scale = TRUE) {
  # Executar PCA
  pca_result <- prcomp(data, scale. = scale)
  
  # Calcular proporção da variância explicada
  variance_explained <- summary(pca_result)$importance[2, ]
  cumulative_variance <- summary(pca_result)$importance[3, ]
  
  # Criar biplot
  biplot_pca <- ggplot2::autoplot(pca_result, 
                                  data = data, 
                                  loadings = TRUE, 
                                  loadings.label = TRUE) +
    theme_minimal() +
    labs(title = "PCA Biplot")
  
  # Scree plot
  scree_plot <- data.frame(
    PC = 1:length(variance_explained),
    Variance = variance_explained
  ) %>%
    ggplot(aes(x = PC, y = Variance)) +
    geom_line() + geom_point() +
    labs(title = "Scree Plot", x = "Principal Component", y = "Proportion of Variance") +
    theme_minimal()
  
  return(list(
    pca_result = pca_result,
    variance_explained = variance_explained,
    biplot = biplot_pca,
    scree_plot = scree_plot
  ))
}

# Análise de Agrupamentos
perform_cluster_analysis <- function(data, k_range = 2:10) {
  # Determinar número ótimo de clusters (método do cotovelo)
  wss <- map_dbl(k_range, ~{
    kmeans(data, centers = .x, nstart = 20)$tot.withinss
  })
  
  elbow_plot <- data.frame(k = k_range, wss = wss) %>%
    ggplot(aes(x = k, y = wss)) +
    geom_line() + geom_point() +
    labs(title = "Elbow Method for Optimal k", x = "Number of Clusters", y = "Within-cluster Sum of Squares") +
    theme_minimal()
  
  # Executar k-means com k ótimo
  optimal_k <- k_range[which.min(diff(wss, differences = 2)) + 1]
  kmeans_result <- kmeans(data, centers = optimal_k, nstart = 20)
  
  # Análise hierárquica
  hclust_result <- hclust(dist(data), method = "ward.D2")
  
  # Dendrograma
  dendrogram <- ggdendro::ggdendrogram(hclust_result) +
    labs(title = "Hierarchical Clustering Dendrogram") +
    theme_minimal()
  
  return(list(
    kmeans_result = kmeans_result,
    hclust_result = hclust_result,
    optimal_k = optimal_k,
    elbow_plot = elbow_plot,
    dendrogram = dendrogram
  ))
}
```

### 📊 Modelagem Estatística Avançada

```r
# Regressão Linear Múltipla com Diagnósticos
advanced_linear_regression <- function(formula, data) {
  # Ajustar modelo
  model <- lm(formula, data = data)
  
  # Diagnósticos do modelo
  diagnostics <- list(
    residuals_vs_fitted = ggplot(data.frame(fitted = fitted(model), 
                                           residuals = residuals(model)),
                                aes(x = fitted, y = residuals)) +
      geom_point() + geom_smooth(se = FALSE) +
      labs(title = "Residuals vs Fitted", x = "Fitted Values", y = "Residuals") +
      theme_minimal(),
    
    qq_plot = ggplot(data.frame(sample = qqnorm(residuals(model), plot.it = FALSE)$x,
                               theoretical = qqnorm(residuals(model), plot.it = FALSE)$y),
                    aes(sample = sample)) +
      stat_qq() + stat_qq_line() +
      labs(title = "Q-Q Plot of Residuals") +
      theme_minimal(),
    
    scale_location = ggplot(data.frame(fitted = fitted(model),
                                      sqrt_abs_residuals = sqrt(abs(residuals(model)))),
                           aes(x = fitted, y = sqrt_abs_residuals)) +
      geom_point() + geom_smooth(se = FALSE) +
      labs(title = "Scale-Location Plot", x = "Fitted Values", y = "√|Residuals|") +
      theme_minimal()
  )
  
  # Testes de pressupostos
  assumptions_tests <- list(
    normality_test = shapiro.test(residuals(model)),
    homoscedasticity_test = car::ncvTest(model),
    independence_test = car::durbinWatsonTest(model)
  )
  
  # Análise de influência
  influence_measures <- influence.measures(model)
  
  return(list(
    model = model,
    summary = summary(model),
    diagnostics = diagnostics,
    assumptions_tests = assumptions_tests,
    influence_measures = influence_measures
  ))
}

# Modelos Lineares Generalizados (GLM)
advanced_glm_analysis <- function(formula, data, family = "binomial") {
  # Ajustar GLM
  glm_model <- glm(formula, data = data, family = family)
  
  # Análise de deviance
  deviance_analysis <- anova(glm_model, test = "Chisq")
  
  # Pseudo R-squared
  null_deviance <- glm_model$null.deviance
  residual_deviance <- glm_model$deviance
  pseudo_r2 <- 1 - (residual_deviance / null_deviance)
  
  # Curva ROC (para modelos logísticos)
  if (family == "binomial") {
    predicted_probs <- predict(glm_model, type = "response")
    roc_curve <- pROC::roc(data[[all.vars(formula)[1]]], predicted_probs)
    
    roc_plot <- pROC::ggroc(roc_curve) +
      labs(title = paste("ROC Curve (AUC =", round(pROC::auc(roc_curve), 3), ")")) +
      theme_minimal()
  } else {
    roc_plot <- NULL
  }
  
  return(list(
    model = glm_model,
    summary = summary(glm_model),
    deviance_analysis = deviance_analysis,
    pseudo_r2 = pseudo_r2,
    roc_plot = roc_plot
  ))
}
```

### ⏱️ Análise de Séries Temporais

```r
# Análise Completa de Séries Temporais
comprehensive_time_series_analysis <- function(ts_data, frequency = 12) {
  # Converter para objeto ts
  if (!is.ts(ts_data)) {
    ts_data <- ts(ts_data, frequency = frequency)
  }
  
  # Decomposição da série temporal
  decomposition <- decompose(ts_data, type = "multiplicative")
  
  # Plot de decomposição
  decomp_plot <- autoplot(decomposition) +
    labs(title = "Time Series Decomposition") +
    theme_minimal()
  
  # Teste de estacionariedade
  adf_test <- tseries::adf.test(ts_data)
  kpss_test <- tseries::kpss.test(ts_data)
  
  # Identificação do modelo ARIMA
  auto_arima <- forecast::auto.arima(ts_data)
  
  # Previsão
  forecast_result <- forecast::forecast(auto_arima, h = 12)
  
  # Plot de previsão
  forecast_plot <- autoplot(forecast_result) +
    labs(title = "ARIMA Forecast", x = "Time", y = "Value") +
    theme_minimal()
  
  # Análise espectral
  spectrum_analysis <- spectrum(ts_data, plot = FALSE)
  
  spectrum_plot <- data.frame(
    frequency = spectrum_analysis$freq,
    power = spectrum_analysis$spec
  ) %>%
    ggplot(aes(x = frequency, y = power)) +
    geom_line() +
    labs(title = "Spectral Density", x = "Frequency", y = "Power") +
    theme_minimal()
  
  return(list(
    decomposition = decomposition,
    decomp_plot = decomp_plot,
    stationarity_tests = list(adf = adf_test, kpss = kpss_test),
    arima_model = auto_arima,
    forecast = forecast_result,
    forecast_plot = forecast_plot,
    spectrum_plot = spectrum_plot
  ))
}
```

### 🤖 Machine Learning Estatístico

```r
# Ensemble de Modelos com Validação Cruzada
ensemble_modeling <- function(formula, data, test_size = 0.3) {
  # Divisão treino/teste
  set.seed(123)
  train_indices <- sample(nrow(data), size = floor((1 - test_size) * nrow(data)))
  train_data <- data[train_indices, ]
  test_data <- data[-train_indices, ]
  
  # Modelos individuais
  models <- list(
    rf = randomForest::randomForest(formula, data = train_data, ntree = 500),
    svm = e1071::svm(formula, data = train_data, kernel = "radial"),
    glm = glm(formula, data = train_data, family = "binomial")
  )
  
  # Predições
  predictions <- map(models, ~predict(.x, test_data, type = "response"))
  
  # Ensemble (média das predições)
  ensemble_pred <- rowMeans(do.call(cbind, predictions))
  
  # Avaliação dos modelos
  actual <- test_data[[all.vars(formula)[1]]]
  
  performance <- map_dfr(predictions, ~{
    pred_binary <- ifelse(.x > 0.5, 1, 0)
    data.frame(
      accuracy = mean(pred_binary == actual),
      precision = sum(pred_binary == 1 & actual == 1) / sum(pred_binary == 1),
      recall = sum(pred_binary == 1 & actual == 1) / sum(actual == 1)
    )
  }, .id = "model")
  
  # Performance do ensemble
  ensemble_binary <- ifelse(ensemble_pred > 0.5, 1, 0)
  ensemble_performance <- data.frame(
    model = "ensemble",
    accuracy = mean(ensemble_binary == actual),
    precision = sum(ensemble_binary == 1 & actual == 1) / sum(ensemble_binary == 1),
    recall = sum(ensemble_binary == 1 & actual == 1) / sum(actual == 1)
  )
  
  performance <- rbind(performance, ensemble_performance)
  
  # Plot de comparação
  performance_plot <- performance %>%
    pivot_longer(cols = c(accuracy, precision, recall), names_to = "metric", values_to = "value") %>%
    ggplot(aes(x = model, y = value, fill = metric)) +
    geom_col(position = "dodge") +
    labs(title = "Model Performance Comparison", x = "Model", y = "Score") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1))
  
  return(list(
    models = models,
    predictions = predictions,
    ensemble_pred = ensemble_pred,
    performance = performance,
    performance_plot = performance_plot
  ))
}
```

## 🎛️ Aplicações Shiny Interativas

### Dashboard Multivariado

```r
# ui.R para explorador multivariado
multivariate_ui <- fluidPage(
  titlePanel("Advanced Multivariate Analysis Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload Dataset",
                accept = c(".csv", ".xlsx")),
      
      selectInput("analysis_type", "Analysis Type:",
                  choices = c("PCA" = "pca",
                             "Factor Analysis" = "fa",
                             "Cluster Analysis" = "cluster")),
      
      conditionalPanel(
        condition = "input.analysis_type == 'pca'",
        checkboxInput("scale_pca", "Scale Variables", value = TRUE),
        sliderInput("n_components", "Number of Components:", 
                   min = 2, max = 10, value = 5)
      ),
      
      conditionalPanel(
        condition = "input.analysis_type == 'cluster'",
        sliderInput("k_clusters", "Number of Clusters:",
                   min = 2, max = 10, value = 3),
        selectInput("cluster_method", "Clustering Method:",
                   choices = c("K-means" = "kmeans",
                              "Hierarchical" = "hclust"))
      ),
      
      actionButton("run_analysis", "Run Analysis", class = "btn-primary")
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Data Summary",
                 h3("Dataset Overview"),
                 DT::dataTableOutput("data_summary")),
        
        tabPanel("Analysis Results",
                 h3("Analysis Output"),
                 plotlyOutput("main_plot"),
                 verbatimTextOutput("analysis_summary")),
        
        tabPanel("Diagnostics",
                 h3("Model Diagnostics"),
                 plotOutput("diagnostic_plots")),
        
        tabPanel("Export",
                 h3("Export Results"),
                 downloadButton("download_results", "Download Report"))
      )
    )
  )
)
```

## 📊 Casos de Uso

### 1. Pesquisa Científica
- Análise de dados experimentais
- Testes de hipóteses múltiplas
- Meta-análises

### 2. Análise de Mercado
- Segmentação de clientes
- Análise de preferências
- Previsão de demanda

### 3. Controle de Qualidade
- Análise de variabilidade
- Controle estatístico de processos
- Análise de capacidade

### 4. Ciências Sociais
- Análise de surveys
- Modelagem de comportamento
- Análise psicométrica

## 🔧 Configuração

### Arquivo de Configuração

```r
# config.R
STATISTICAL_CONFIG <- list(
  # Configurações gerais
  significance_level = 0.05,
  confidence_level = 0.95,
  random_seed = 123,
  
  # Configurações de visualização
  plot_theme = "minimal",
  color_palette = "viridis",
  figure_width = 10,
  figure_height = 8,
  
  # Configurações de modelagem
  cv_folds = 10,
  bootstrap_samples = 1000,
  max_iterations = 1000,
  
  # Configurações de cluster
  cluster_methods = c("kmeans", "hclust", "pam"),
  distance_metrics = c("euclidean", "manhattan", "gower"),
  
  # Configurações de séries temporais
  ts_frequency = 12,
  forecast_horizon = 12,
  seasonal_periods = c(12, 4, 7)
)
```

## 📄 Licença

Este projeto está licenciado sob a Licença MIT - veja o arquivo [LICENSE](LICENSE) para detalhes.

## 👨‍💻 Autor

**Gabriel Demetrios Lafis**

- GitHub: [@galafis](https://github.com/galafis)
- Email: gabrieldemetrios@gmail.com

---

⭐ Se este projeto foi útil, considere deixar uma estrela!

