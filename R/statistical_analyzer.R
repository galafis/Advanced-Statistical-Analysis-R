library(ggplot2)
library(dplyr)
library(corrplot)
library(VIM)
library(mice)
library(car)
library(lmtest)
library(forecast)
library(cluster)
library(factoextra)
library(R6)

# Advanced Statistical Analysis Class
StatisticalAnalyzer <- R6::R6Class("StatisticalAnalyzer",
  public = list(
    data = NULL,
    results = list(),
    
    initialize = function(data = NULL) {
      if (is.null(data)) {
        stop("Data cannot be NULL. Please provide a dataset.")
      }
      if (!is.data.frame(data)) {
        stop("Data must be a data.frame.")
      }
      self$data <- data
      cat("Statistical Analyzer initialized\n")
    },
    
    # Comprehensive descriptive statistics
    descriptive_analysis = function() {
      if (is.null(self$data)) {
        stop("No data loaded. Please load data first.")
      }
      
      desc_stats <- list(
        summary = summary(self$data),
        structure = str(self$data),
        missing_values = sapply(self$data, function(x) sum(is.na(x))),
        correlation_matrix = cor(select_if(self$data, is.numeric), use = "complete.obs")
      )
      
      self$results$descriptive <- desc_stats
      return(desc_stats)
    },
    
    # Advanced hypothesis testing
    hypothesis_testing = function(x, y = NULL, test_type = "t.test") {
      if (!test_type %in% c("t.test", "wilcox.test", "ks.test", "chisq.test")) {
        stop("Invalid test_type. Choose from 't.test', 'wilcox.test', 'ks.test', 'chisq.test'.")
      }
      
      results <- switch(test_type,
        "t.test" = t.test(x, y),
        "wilcox.test" = wilcox.test(x, y),
        "ks.test" = ks.test(x, y),
        "chisq.test" = chisq.test(x, y)
      )
      
      self$results$hypothesis_test <- results
      return(results)
    },
    
    # Regression analysis with diagnostics
    regression_analysis = function(formula, method = "lm") {
      if (!method %in% c("lm", "glm", "lmer")) {
        stop("Invalid method. Choose from 'lm', 'glm', 'lmer'.")
      }
      
      model <- switch(method,
        "lm" = lm(formula, data = self$data),
        "glm" = glm(formula, data = self$data),
        "lmer" = lme4::lmer(formula, data = self$data)
      )
      
      # Model diagnostics
      diagnostics <- list(
        summary = summary(model),
        anova = anova(model),
        residuals = residuals(model),
        fitted_values = fitted(model),
        cook_distance = cooks.distance(model)
      )
      
      self$results$regression <- list(model = model, diagnostics = diagnostics)
      return(list(model = model, diagnostics = diagnostics))
    },
    
    # Time series analysis
    time_series_analysis = function(ts_data, frequency = 12) {
      if (!is.numeric(ts_data)) {
        stop("ts_data must be numeric.")
      }
      ts_object <- ts(ts_data, frequency = frequency)
      
      # Decomposition
      decomp <- decompose(ts_object)
      
      # ARIMA modeling
      arima_model <- auto.arima(ts_object)
      
      # Forecasting
      forecast_result <- forecast(arima_model, h = 12)
      
      results <- list(
        time_series = ts_object,
        decomposition = decomp,
        arima_model = arima_model,
        forecast = forecast_result
      )
      
      self$results$time_series <- results
      return(results)
    },
    
    # Cluster analysis
    cluster_analysis = function(k = 3, method = "kmeans") {
      if (!method %in% c("kmeans", "hierarchical", "pam")) {
        stop("Invalid method. Choose from 'kmeans', 'hierarchical', 'pam'.")
      }
      numeric_data <- select_if(self$data, is.numeric)
      if (ncol(numeric_data) == 0) {
        stop("No numeric data available for clustering.")
      }
      scaled_data <- scale(numeric_data)
      
      clusters <- switch(method,
        "kmeans" = kmeans(scaled_data, centers = k),
        "hierarchical" = cutree(hclust(dist(scaled_data)), k = k),
        "pam" = pam(scaled_data, k = k)
      )
      
      self$results$clusters <- clusters
      return(clusters)
    },
    
    # Generate comprehensive report
    generate_report = function(output_file = "statistical_report.html") {
      # Create comprehensive statistical report
      report_content <- paste(
        "# Advanced Statistical Analysis Report",
        "Generated on:", Sys.Date(),
        "\n## Data Overview",
        "Observations:", nrow(self$data),
        "Variables:", ncol(self$data),
        "\n## Analysis Results Available:",
        paste(names(self$results), collapse = ", "),
        sep = "\n"
      )
      
      writeLines(report_content, output_file)
      cat("Report generated:", output_file, "\n")
    }
  )
)

