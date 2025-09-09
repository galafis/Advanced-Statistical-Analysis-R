# Advanced Statistical Analysis R - R Scripts Directory / Diretório de Scripts R

## English

### Overview
This directory contains modular R scripts for comprehensive statistical analysis. Each script is designed to handle specific aspects of data analysis, from preprocessing to advanced statistical modeling.

### Scripts Description

#### 🔧 **data_preprocessing.R**
**Purpose**: Data cleaning, transformation, and preparation
- Data loading and inspection functions
- Missing data analysis and imputation (MICE algorithm)
- Outlier detection and removal (IQR method)
- Data normalization and standardization
- Categorical variable encoding
- Complete preprocessing pipeline with validation

#### 📊 **descriptive_analysis.R**
**Purpose**: Exploratory data analysis and descriptive statistics
- Univariate and bivariate analysis
- Summary statistics calculation
- Distribution analysis and normality testing
- Correlation analysis
- Data visualization for exploration

#### 🧪 **hypothesis_testing.R**
**Purpose**: Statistical hypothesis testing
- Parametric tests (t-test, ANOVA, chi-square)
- Non-parametric tests (Mann-Whitney U, Kruskal-Wallis)
- Effect size calculations
- Power analysis
- Multiple comparison corrections

#### 📈 **regression_analysis.R**
**Purpose**: Linear and non-linear regression modeling
- Simple and multiple linear regression
- Model diagnostics and validation
- Polynomial and logistic regression
- Regularization techniques (Ridge, Lasso)
- Model comparison and selection

#### 🔍 **multivariate_analysis.R**
**Purpose**: Advanced multivariate statistical techniques
- Principal Component Analysis (PCA)
- Factor Analysis
- Cluster Analysis (k-means, hierarchical)
- Discriminant Analysis
- MANOVA (Multivariate Analysis of Variance)

#### ⏰ **time_series_analysis.R**
**Purpose**: Time series data analysis and forecasting
- Time series decomposition
- Stationarity testing
- ARIMA modeling
- Seasonal analysis
- Forecasting and validation

#### 🤖 **machine_learning.R**
**Purpose**: Machine learning algorithms implementation
- Supervised learning (Random Forest, SVM)
- Unsupervised learning (clustering algorithms)
- Model evaluation and cross-validation
- Feature selection techniques
- Hyperparameter tuning

#### 📋 **categorical_analysis.R**
**Purpose**: Categorical data analysis
- Contingency tables and chi-square tests
- Log-linear models
- Ordinal data analysis
- Association measures
- Categorical data visualization

#### ⚕️ **survival_analysis.R**
**Purpose**: Survival and time-to-event analysis
- Kaplan-Meier estimation
- Cox proportional hazards model
- Log-rank tests
- Survival curves comparison
- Hazard ratio calculations

#### 📉 **visualization.R**
**Purpose**: Advanced data visualization
- Statistical plots (histograms, boxplots, scatterplots)
- Custom themes and styling
- Interactive visualizations
- Publication-ready graphics
- Dashboard components

### How to Use

1. **Individual Scripts**: Each script can be sourced independently
   ```r
   source("data_preprocessing.R")
   source("descriptive_analysis.R")
   # etc.
   ```

2. **Pipeline Approach**: Use scripts in sequence for complete analysis
   ```r
   # 1. Data preprocessing
   cleaned_data <- preprocess_data_pipeline("your_data.csv")
   
   # 2. Descriptive analysis
   descriptive_results <- perform_descriptive_analysis(cleaned_data)
   
   # 3. Statistical modeling
   model_results <- perform_regression_analysis(cleaned_data)
   ```

3. **Required Dependencies**: Each script loads necessary packages automatically
   - Run `install.packages()` for any missing packages
   - Check script headers for specific requirements

### Future Expansions

- **Bayesian Statistics Module**: Implementation of Bayesian inference techniques
- **Text Analytics Module**: Natural language processing and text mining
- **Spatial Analysis Module**: Geographic and spatial data analysis
- **Deep Learning Integration**: Neural networks and deep learning models
- **Automated Reporting**: Dynamic report generation with R Markdown

---

## Português

### Visão Geral
Este diretório contém scripts R modulares para análise estatística abrangente. Cada script é projetado para lidar com aspectos específicos da análise de dados, desde pré-processamento até modelagem estatística avançada.

### Descrição dos Scripts

#### 🔧 **data_preprocessing.R**
**Propósito**: Limpeza, transformação e preparação de dados
- Funções de carregamento e inspeção de dados
- Análise e imputação de dados faltantes (algoritmo MICE)
- Detecção e remoção de outliers (método IQR)
- Normalização e padronização de dados
- Codificação de variáveis categóricas
- Pipeline completo de pré-processamento com validação

#### 📊 **descriptive_analysis.R**
**Propósito**: Análise exploratória e estatísticas descritivas
- Análise univariada e bivariada
- Cálculo de estatísticas resumo
- Análise de distribuição e testes de normalidade
- Análise de correlação
- Visualização de dados para exploração

#### 🧪 **hypothesis_testing.R**
**Propósito**: Testes de hipóteses estatísticas
- Testes paramétricos (t-test, ANOVA, qui-quadrado)
- Testes não-paramétricos (Mann-Whitney U, Kruskal-Wallis)
- Cálculos de tamanho de efeito
- Análise de poder estatístico
- Correções para múltiplas comparações

#### 📈 **regression_analysis.R**
**Propósito**: Modelagem de regressão linear e não-linear
- Regressão linear simples e múltipla
- Diagnósticos e validação de modelos
- Regressão polinomial e logística
- Técnicas de regularização (Ridge, Lasso)
- Comparação e seleção de modelos

#### 🔍 **multivariate_analysis.R**
**Propósito**: Técnicas estatísticas multivariadas avançadas
- Análise de Componentes Principais (PCA)
- Análise Fatorial
- Análise de Clusters (k-means, hierárquico)
- Análise Discriminante
- MANOVA (Análise de Variância Multivariada)

#### ⏰ **time_series_analysis.R**
**Propósito**: Análise de séries temporais e previsão
- Decomposição de séries temporais
- Testes de estacionariedade
- Modelagem ARIMA
- Análise sazonal
- Previsão e validação

#### 🤖 **machine_learning.R**
**Propósito**: Implementação de algoritmos de aprendizado de máquina
- Aprendizado supervisionado (Random Forest, SVM)
- Aprendizado não supervisionado (algoritmos de clustering)
- Avaliação de modelos e validação cruzada
- Técnicas de seleção de características
- Ajuste de hiperparâmetros

#### 📋 **categorical_analysis.R**
**Propósito**: Análise de dados categóricos
- Tabelas de contingência e testes qui-quadrado
- Modelos log-lineares
- Análise de dados ordinais
- Medidas de associação
- Visualização de dados categóricos

#### ⚕️ **survival_analysis.R**
**Propósito**: Análise de sobrevivência e tempo até evento
- Estimação Kaplan-Meier
- Modelo de riscos proporcionais de Cox
- Testes log-rank
- Comparação de curvas de sobrevivência
- Cálculos de razão de risco

#### 📉 **visualization.R**
**Propósito**: Visualização avançada de dados
- Gráficos estatísticos (histogramas, boxplots, dispersão)
- Temas e estilos personalizados
- Visualizações interativas
- Gráficos prontos para publicação
- Componentes de dashboard

### Como Usar

1. **Scripts Individuais**: Cada script pode ser carregado independentemente
   ```r
   source("data_preprocessing.R")
   source("descriptive_analysis.R")
   # etc.
   ```

2. **Abordagem Pipeline**: Use scripts em sequência para análise completa
   ```r
   # 1. Pré-processamento de dados
   dados_limpos <- preprocess_data_pipeline("seus_dados.csv")
   
   # 2. Análise descritiva
   resultados_descritivos <- perform_descriptive_analysis(dados_limpos)
   
   # 3. Modelagem estatística
   resultados_modelo <- perform_regression_analysis(dados_limpos)
   ```

3. **Dependências Necessárias**: Cada script carrega pacotes necessários automaticamente
   - Execute `install.packages()` para pacotes faltantes
   - Verifique cabeçalhos dos scripts para requisitos específicos

### Expansões Futuras

- **Módulo de Estatística Bayesiana**: Implementação de técnicas de inferência bayesiana
- **Módulo de Análise de Texto**: Processamento de linguagem natural e mineração de texto
- **Módulo de Análise Espacial**: Análise de dados geográficos e espaciais
- **Integração Deep Learning**: Redes neurais e modelos de aprendizado profundo
- **Relatórios Automatizados**: Geração dinâmica de relatórios com R Markdown

---

## 📞 Contact / Contato

**Author / Autor**: Gabriel Demetrios Lafis  
**Repository / Repositório**: [Advanced-Statistical-Analysis-R](https://github.com/galafis/Advanced-Statistical-Analysis-R)

---

## 📄 License / Licença

This project is open source. Please refer to the main repository for license information.  
Este projeto é código aberto. Consulte o repositório principal para informações sobre licença.
