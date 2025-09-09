# Advanced Statistical Analysis R - Package Dependencies
# Automated installation script for all required packages
# Created by Gabriel Demetrios Lafis

# Function to install packages if not already installed
install_if_missing <- function(pkg) {
  if (!require(pkg, character.only = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
    library(pkg, character.only = TRUE)
  }
}

# Core Statistical Packages
cat("Installing Core Statistical Packages...\n")
install_if_missing("stats")
install_if_missing("MASS")
install_if_missing("car")
install_if_missing("lmtest")
install_if_missing("broom")

# Data Manipulation & Visualization
cat("Installing Data Manipulation & Visualization packages...\n")
install_if_missing("dplyr")
install_if_missing("tidyr")
install_if_missing("ggplot2")
install_if_missing("plotly")
install_if_missing("corrplot")
install_if_missing("VIM")
install_if_missing("mice")

# Advanced Statistical Methods
cat("Installing Advanced Statistical Methods...\n")
install_if_missing("psych")
install_if_missing("cluster")
install_if_missing("survival")
install_if_missing("forecast")
install_if_missing("randomForest")
install_if_missing("e1071")
install_if_missing("factoextra")
install_if_missing("ggdendro")
install_if_missing("pROC")
install_if_missing("tseries")

# Specialized Analysis
cat("Installing Specialized Analysis packages...\n")
install_if_missing("vegan")
install_if_missing("lavaan")
install_if_missing("nlme")
install_if_missing("mgcv")
install_if_missing("lme4")

# Interactive Applications
cat("Installing Interactive Applications packages...\n")
install_if_missing("shiny")
install_if_missing("DT")
install_if_missing("shinydashboard")
install_if_missing("shinyWidgets")

# Utility packages
cat("Installing Utility packages...\n")
install_if_missing("R6")
install_if_missing("purrr")
install_if_missing("readr")
install_if_missing("readxl")
install_if_missing("writexl")
install_if_missing("knitr")
install_if_missing("rmarkdown")

# Data visualization enhancements
cat("Installing Data Visualization enhancements...\n")
install_if_missing("ggfortify")
install_if_missing("gridExtra")
install_if_missing("ggthemes")
install_if_missing("viridis")
install_if_missing("RColorBrewer")

cat("\n=== Package Installation Complete ===\n")
cat("All required packages for Advanced Statistical Analysis R have been installed.\n")
cat("You can now run the main analysis by executing: source('statistical_analysis.R')\n")

# Check R version compatibility
cat("\nR Version Check:\n")
cat(paste("Current R version:", R.version.string, "\n"))
if (R.Version()$major >= 4 && R.Version()$minor >= 3) {
  cat("✓ R version is compatible (4.3+)\n")
} else {
  warning("⚠ R version may be too old. Recommended: R 4.3+")
}

cat("\nSetup complete! Ready for statistical analysis.\n")
