################################################################################
## BLOG OF JUAN IRIGOYEN
## (1) DATA RETRIEVAL
## R script written by Jose Luis Estevez (University of Helsinki)
## Date: Jan 1st, 2025
################################################################################

# R PACKAGES REQUIRED
library(tidyverse);library(rvest);library(lubridate);library(stringr)

# Clean the environment
rm(list=ls())

################################################################################

# RETRIEVE ALL URLS FROM THE BLOG WEBSITE ----

# Step 1: Define the main page URL
main_url <- "http://www.juanirigoyen.es/"
all_post_links <- c()

# Step 2: Start scraping from the main page and follow pagination
current_page <- main_url
while (!is.null(current_page)) {
  # Read the current page
  page <- read_html(current_page)
  # Extract links to individual posts
  post_links <- page %>%
    html_elements("a") %>%
    html_attr("href") %>%
    unique()
  # Filter links to include only individual posts (e.g., "YYYY/MM/post-title")
  filtered_posts <- post_links[grepl("\\d{4}/\\d{2}/.+", post_links)]
  all_post_links <- c(all_post_links, filtered_posts)
  # Find the "Older Posts" (pagination) button and update current_page
  next_button <- page %>%
    html_element(".blog-pager-older-link") %>% # Adjust to the correct class for "Older Posts"
    html_attr("href")
  # If there's no "Older Posts" button, stop pagination
  current_page <- next_button
}
# Remove duplicate links
all_post_links <- unique(all_post_links)

# Step 3: Filter URLs with specific conditions
# Include only URLs that contain the keyword "juanirigoyen"
urls <- all_post_links[grepl("juanirigoyen", all_post_links, ignore.case = TRUE)]
# Exclude mailto links
urls <- urls[!grepl("mailto", urls, ignore.case = TRUE)]

################################################################################

# DATA SCRAPING ----

# Pages
pages <- lapply(urls,read_html)

# Extract title, date, and body of text
# Function for extraction
extraction <- function(page){
  outcome <- list()
  outcome[['title']] <- page %>%
    html_elements(".post-title") %>% # Adjust based on the actual class or tag for the title
    html_text2()
  outcome[['date']] <- page %>%
    html_elements(".date-header") %>% # Adjust based on the actual class or tag for the date
    html_text2()
  outcome[['text']] <- page %>%
    html_elements(".post-body") %>%
    html_text2()
  # return
  return(outcome)
}
# Apply function
data <- lapply(pages,extraction)

################################################################################

# USE R READABLE DATES ----

post_dates <- c()
for(i in seq_along(data)){
  post_dates[[i]] <- data[[i]]$date
}

convert_dates <- function(date_string){
  # Step 1: Remove the day of the week
  cleaned_date <- str_remove(date_string, "^[a-zA-Záéíóúñ]+,\\s*")
  # Step 2: Replace Spanish month names with English equivalents
  spanish_months <- c("enero", "febrero", "marzo", "abril", "mayo", "junio",
                      "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre")
  english_months <- c("January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December")
  for (i in seq_along(spanish_months)) {
    cleaned_date <- str_replace_all(cleaned_date, spanish_months[i], english_months[i])
  }
  # Step 3: Convert to a Date object
  standard_date <- dmy(cleaned_date)
  return(standard_date)
}
post_dates <- lapply(post_dates,convert_dates)

# Turn into vector
post_dates <- as.Date(unlist(post_dates), origin = "1970-01-01")

# Replace values
for(i in seq_along(data)){
  data[[i]]$date <- as.character(post_dates)[i]
}

# Finally, let's order the entries by date
data <- data[order(post_dates)]
# Optional: title each entry with the date as well
names(data) <- post_dates[order(post_dates)] 

################################################################################

# Export as txt files
for(i in seq_along(data)){
  title <- paste('post ',i,' (',names(data)[[i]],').txt',sep='')
  writeLines(unlist(data[[i]]),title)
}

################################################################################

# Remove unnecessary objects
rm(list=setdiff(ls(),c('all_post_links','data')))

# Save image
save.image('Irigoyen_blog.RData')

################################################################################