# ==============================================================================
# Data Preprocessing Module
# Advanced Statistical Analysis R
# ==============================================================================
# Description: Comprehensive data preprocessing functions for statistical analysis
# Author: Gabriel Demetrios Lafis
# ==============================================================================

# Load required libraries
suppressPackageStartupMessages({
  library(dplyr)
  library(tidyr)
  library(VIM)  # for missing data visualization
  library(mice) # for multiple imputation
  library(psych) # for data summary
})

# ==============================================================================
# DATA LOADING AND INSPECTION FUNCTIONS
# ==============================================================================

#' Load and inspect dataset
#' @param file_path Path to the data file (CSV, Excel, etc.)
#' @param sheet_name For Excel files, specify sheet name
#' @return List containing data and inspection results
load_and_inspect_data <- function(file_path, sheet_name = NULL) {
  # Determine file type and load accordingly
  file_ext <- tools::file_ext(file_path)
  
  data <- switch(tolower(file_ext),
    "csv" = readr::read_csv(file_path),
    "xlsx" = readxl::read_excel(file_path, sheet = sheet_name),
    "xls" = readxl::read_excel(file_path, sheet = sheet_name),
    "rds" = readRDS(file_path),
    stop("Unsupported file format")
  )
  
  # Data inspection
  inspection <- list(
    dimensions = dim(data),
    column_names = colnames(data),
    data_types = sapply(data, class),
    missing_values = colSums(is.na(data)),
    summary_stats = psych::describe(data),
    sample_data = head(data, 10)
  )
  
  return(list(
    data = data,
    inspection = inspection
  ))
}

# ==============================================================================
# MISSING DATA HANDLING FUNCTIONS
# ==============================================================================

#' Analyze missing data patterns
#' @param data Input data frame
#' @return List with missing data analysis
analyze_missing_data <- function(data) {
  # Missing data summary
  missing_summary <- data %>%
    summarise_all(~ sum(is.na(.))) %>%
    gather(key = "variable", value = "missing_count") %>%
    mutate(
      missing_percentage = round((missing_count / nrow(data)) * 100, 2)
    ) %>%
    arrange(desc(missing_count))
  
  # Missing data patterns
  missing_patterns <- VIM::md.pattern(data, plot = FALSE)
  
  # Visualization
  missing_plot <- VIM::aggr(data, col = c('navyblue', 'red'), 
                           numbers = TRUE, sortVars = TRUE)
  
  return(list(
    summary = missing_summary,
    patterns = missing_patterns,
    plot = missing_plot
  ))
}

#' Handle missing data through multiple imputation
#' @param data Input data frame
#' @param method Imputation method (default: "pmm" for predictive mean matching)
#' @param m Number of multiple imputations (default: 5)
#' @return Imputed dataset
handle_missing_data <- function(data, method = "pmm", m = 5) {
  # Perform multiple imputation
  imputed <- mice::mice(data, method = method, m = m, printFlag = FALSE)
  
  # Complete the imputation
  completed_data <- mice::complete(imputed)
  
  # Validation plots
  validation_plot <- mice::densityplot(imputed)
  
  return(list(
    imputed_data = completed_data,
    imputation_object = imputed,
    validation_plot = validation_plot
  ))
}

# ==============================================================================
# DATA CLEANING FUNCTIONS
# ==============================================================================

#' Remove outliers using IQR method
#' @param data Input data frame
#' @param columns Columns to check for outliers (default: all numeric)
#' @param multiplier IQR multiplier (default: 1.5)
#' @return Cleaned dataset
remove_outliers_iqr <- function(data, columns = NULL, multiplier = 1.5) {
  if (is.null(columns)) {
    columns <- names(data)[sapply(data, is.numeric)]
  }
  
  outlier_indices <- c()
  
  for (col in columns) {
    Q1 <- quantile(data[[col]], 0.25, na.rm = TRUE)
    Q3 <- quantile(data[[col]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    
    lower_bound <- Q1 - multiplier * IQR
    upper_bound <- Q3 + multiplier * IQR
    
    outliers <- which(data[[col]] < lower_bound | data[[col]] > upper_bound)
    outlier_indices <- c(outlier_indices, outliers)
  }
  
  outlier_indices <- unique(outlier_indices)
  
  if (length(outlier_indices) > 0) {
    cleaned_data <- data[-outlier_indices, ]
    cat("Removed", length(outlier_indices), "outliers\n")
  } else {
    cleaned_data <- data
    cat("No outliers detected\n")
  }
  
  return(list(
    cleaned_data = cleaned_data,
    outlier_indices = outlier_indices,
    original_size = nrow(data),
    cleaned_size = nrow(cleaned_data)
  ))
}

# ==============================================================================
# DATA TRANSFORMATION FUNCTIONS
# ==============================================================================

#' Normalize numeric variables
#' @param data Input data frame
#' @param method Normalization method ("z-score", "min-max", "robust")
#' @param columns Columns to normalize (default: all numeric)
#' @return Normalized dataset
normalize_data <- function(data, method = "z-score", columns = NULL) {
  if (is.null(columns)) {
    columns <- names(data)[sapply(data, is.numeric)]
  }
  
  normalized_data <- data
  
  for (col in columns) {
    if (method == "z-score") {
      normalized_data[[col]] <- scale(data[[col]])[, 1]
    } else if (method == "min-max") {
      min_val <- min(data[[col]], na.rm = TRUE)
      max_val <- max(data[[col]], na.rm = TRUE)
      normalized_data[[col]] <- (data[[col]] - min_val) / (max_val - min_val)
    } else if (method == "robust") {
      median_val <- median(data[[col]], na.rm = TRUE)
      mad_val <- mad(data[[col]], na.rm = TRUE)
      normalized_data[[col]] <- (data[[col]] - median_val) / mad_val
    }
  }
  
  return(normalized_data)
}

#' Encode categorical variables
#' @param data Input data frame
#' @param columns Categorical columns to encode
#' @param method Encoding method ("dummy", "label", "target")
#' @return Encoded dataset
encode_categorical <- function(data, columns, method = "dummy") {
  encoded_data <- data
  
  for (col in columns) {
    if (method == "dummy") {
      # One-hot encoding
      dummy_vars <- model.matrix(~ . - 1, data = data[col])
      colnames(dummy_vars) <- paste0(col, "_", colnames(dummy_vars))
      
      # Remove original column and add dummy variables
      encoded_data <- encoded_data[, !names(encoded_data) %in% col]
      encoded_data <- cbind(encoded_data, dummy_vars)
      
    } else if (method == "label") {
      # Label encoding
      encoded_data[[col]] <- as.numeric(as.factor(data[[col]]))
    }
  }
  
  return(encoded_data)
}

# ==============================================================================
# DATA VALIDATION FUNCTIONS
# ==============================================================================

#' Validate data quality
#' @param data Input data frame
#' @return Data quality report
validate_data_quality <- function(data) {
  quality_report <- list(
    # Basic statistics
    total_rows = nrow(data),
    total_columns = ncol(data),
    
    # Missing data
    total_missing = sum(is.na(data)),
    missing_percentage = round((sum(is.na(data)) / (nrow(data) * ncol(data))) * 100, 2),
    
    # Data types
    numeric_columns = sum(sapply(data, is.numeric)),
    character_columns = sum(sapply(data, is.character)),
    factor_columns = sum(sapply(data, is.factor)),
    logical_columns = sum(sapply(data, is.logical)),
    
    # Duplicates
    duplicate_rows = sum(duplicated(data)),
    
    # Column-wise statistics
    column_stats = data %>%
      summarise_all(list(
        missing = ~ sum(is.na(.)),
        unique_values = ~ n_distinct(.),
        data_type = ~ class(.)[1]
      )) %>%
      gather(key = "metric", value = "value") %>%
      separate(metric, into = c("column", "statistic"), sep = "_") %>%
      spread(key = "statistic", value = "value")
  )
  
  return(quality_report)
}

# ==============================================================================
# MAIN PREPROCESSING PIPELINE
# ==============================================================================

#' Complete data preprocessing pipeline
#' @param file_path Path to input data file
#' @param remove_outliers Whether to remove outliers (default: TRUE)
#' @param normalize Whether to normalize numeric variables (default: TRUE)
#' @param handle_missing Whether to handle missing data (default: TRUE)
#' @return List with processed data and pipeline results
preprocess_data_pipeline <- function(file_path, 
                                   remove_outliers = TRUE,
                                   normalize = TRUE,
                                   handle_missing = TRUE) {
  
  cat("=== Starting Data Preprocessing Pipeline ===\n")
  
  # Step 1: Load and inspect data
  cat("Step 1: Loading and inspecting data...\n")
  loaded_data <- load_and_inspect_data(file_path)
  data <- loaded_data$data
  
  # Step 2: Analyze missing data
  if (handle_missing && sum(is.na(data)) > 0) {
    cat("Step 2: Analyzing and handling missing data...\n")
    missing_analysis <- analyze_missing_data(data)
    
    # Only impute if missing data is not too extensive
    if (mean(is.na(data)) < 0.5) {
      imputation_result <- handle_missing_data(data)
      data <- imputation_result$imputed_data
    } else {
      cat("Warning: Too much missing data (>50%). Consider manual review.\n")
    }
  }
  
  # Step 3: Remove outliers
  if (remove_outliers) {
    cat("Step 3: Removing outliers...\n")
    outlier_result <- remove_outliers_iqr(data)
    data <- outlier_result$cleaned_data
  }
  
  # Step 4: Normalize data
  if (normalize) {
    cat("Step 4: Normalizing numeric variables...\n")
    data <- normalize_data(data, method = "z-score")
  }
  
  # Step 5: Final validation
  cat("Step 5: Final data quality validation...\n")
  final_quality <- validate_data_quality(data)
  
  cat("=== Data Preprocessing Complete ===\n")
  cat("Final dataset dimensions:", dim(data), "\n")
  
  return(list(
    processed_data = data,
    original_inspection = loaded_data$inspection,
    final_quality = final_quality,
    preprocessing_steps = list(
      missing_handled = handle_missing,
      outliers_removed = remove_outliers,
      normalized = normalize
    )
  ))
}

# ==============================================================================
# UTILITY FUNCTIONS
# ==============================================================================

#' Create preprocessing report
#' @param preprocessing_result Result from preprocessing pipeline
#' @param output_path Path to save the report (optional)
create_preprocessing_report <- function(preprocessing_result, output_path = NULL) {
  report <- list(
    timestamp = Sys.time(),
    original_dimensions = preprocessing_result$original_inspection$dimensions,
    final_dimensions = dim(preprocessing_result$processed_data),
    data_quality = preprocessing_result$final_quality,
    preprocessing_steps = preprocessing_result$preprocessing_steps
  )
  
  if (!is.null(output_path)) {
    saveRDS(report, output_path)
    cat("Preprocessing report saved to:", output_path, "\n")
  }
  
  return(report)
}

#' Export processed data
#' @param data Processed data frame
#' @param output_path Output file path
#' @param format Output format ("csv", "rds", "excel")
export_processed_data <- function(data, output_path, format = "csv") {
  switch(format,
    "csv" = readr::write_csv(data, output_path),
    "rds" = saveRDS(data, output_path),
    "excel" = writexl::write_xlsx(data, output_path),
    stop("Unsupported output format")
  )
  
  cat("Processed data exported to:", output_path, "\n")
}

# ==============================================================================
# END OF DATA PREPROCESSING MODULE
# ==============================================================================
