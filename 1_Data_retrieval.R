################################################################################
## BLOG OF JUAN IRIGOYEN
## (1) DATA RETRIEVAL
## R script written by Jose Luis Estevez (University of Helsinki)
## Date: Jan 3rd, 2025
################################################################################

# R PACKAGES REQUIRED
library(tidyverse); library(rvest); library(lubridate); library(stringr)

# Clean the environment
rm(list = ls())

################################################################################

# DATA SCRAPING ----

# Step 1: Define the main page URL
main_url <- "http://www.juanirigoyen.es/"
all_post_links <- c()

# Step 2: Start scraping from the main page and follow pagination
current_page <- main_url
while (!is.null(current_page) && !is.na(current_page)) {
  # Read the current page
  page <- tryCatch(read_html(current_page), error = function(e) NULL)
  if (is.null(page)) break # Stop the loop if the page fails to load
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
    html_element(".blog-pager-older-link") %>%
    html_attr("href")
  # If there's no "Older Posts" button or href is NA, stop pagination
  current_page <- if (!is.na(next_button)) next_button else NULL
}
# Remove duplicate links
all_post_links <- unique(all_post_links)

# Step 3: Filter URLs with specific conditions
# Include only URLs that contain the keyword "juanirigoyen"
urls <- all_post_links[grepl("juanirigoyen", all_post_links, ignore.case = TRUE)]
urls <- urls[!grepl("mailto", urls, ignore.case = TRUE)]

# Step 4: Extract title, date, body of text, images, and links to videos
pages <- lapply(urls, read_html)

extraction <- function(page) {
  outcome <- list()
  # Extract title
  outcome[['title']] <- page %>%
    html_elements(".post-title") %>% 
    html_text2()
  # Extract date
  outcome[['date']] <- page %>%
    html_elements(".date-header") %>% 
    html_text2()
  # Extract body of text
  outcome[['text']] <- page %>%
    html_elements(".post-body") %>%
    html_text2()
  # Extract image URLs
  outcome[['images']] <- page %>%
    html_elements(".post-body img") %>% 
    html_attr("src") %>%
    unique()
  # Extract video URLs and sources
  outcome[['videos']] <- page %>%
    html_elements(".post-body iframe, .post-body video, .post-body a[href*='video']") %>% 
    html_attr("src") %>% 
    unique()
  return(outcome)
}

data <- lapply(pages, extraction)

# Step 5: Combine data into a data frame
data_frame <- do.call(rbind, lapply(data, function(x) {
  data.frame(
    title = paste(x$title, collapse = " "),
    date = paste(x$date, collapse = " "),
    text = paste(x$text, collapse = " "),
    images = paste(x$images, collapse = " | "),
    videos = paste(x$videos, collapse = " | "),
    stringsAsFactors = FALSE
  )
}))

# Step 6: Order posts by date of publication
convert_dates <- function(date_string) {
  cleaned_date <- str_remove(date_string, "^[a-zA-Záéíóúñ]+,\\s*")
  spanish_months <- c("enero", "febrero", "marzo", "abril", "mayo", "junio",
                      "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre")
  english_months <- c("January", "February", "March", "April", "May", "June",
                      "July", "August", "September", "October", "November", "December")
  for (i in seq_along(spanish_months)) {
    cleaned_date <- str_replace_all(cleaned_date, spanish_months[i], english_months[i])
  }
  standard_date <- dmy(cleaned_date)
  return(standard_date)
}

data_frame$date <- convert_dates(data_frame$date)
data_frame <- data_frame[order(data_frame$date, decreasing = FALSE), ]
row.names(data_frame) <- 1:nrow(data_frame)
data_frame$date <- as.character(data_frame$date)

# Remove unnecessary objects
rm(list=setdiff(ls(),c('data_frame')))

# Save image
save.image('Irigoyen_blog.RData')

################################################################################

# EXPORTING DATA ----

# Create the main export directory
export_dir <- "exported_posts"
dir.create(export_dir, showWarnings = FALSE)

# Create the images subfolder
images_dir <- file.path(export_dir, "images")
dir.create(images_dir, showWarnings = FALSE)

# Export text files
for (i in 1:nrow(data_frame)) {
  title <- paste("post_", i, "_(", data_frame$date[i], ").txt", sep = "")
  file_path <- file.path(export_dir, title)
  
  # Prepare the content for the text file
  content <- c(
    paste("Título:", data_frame$title[i]),
    paste("Fecha:", data_frame$date[i]),
    paste("Contenido:", data_frame$text[i]),
    if (data_frame$videos[i] != "") {
      paste("\nVídeos:\n", paste(data_frame$videos[i], collapse = "\n"))
    } else {
      ""
    }
  )
  # Write the content to the text file
  writeLines(content, file_path)
}

# Download images for posts with images
has_images <- which(data_frame$images != "" & !is.na(data_frame$images))
if (length(has_images) > 0) {
  for (i in has_images) {
    image_urls <- str_split(data_frame$images[i], " \\| ")[[1]]
    post_images_dir <- file.path(images_dir, paste0("post_", i))
    dir.create(post_images_dir, showWarnings = FALSE)
    for (j in seq_along(image_urls)) {
      img_url <- image_urls[j]
      img_ext <- tools::file_ext(img_url)
      img_file <- file.path(post_images_dir, paste0("image_", j, ".", img_ext))
      try(download.file(img_url, img_file, mode = "wb"), silent = TRUE)
    }
  }
}

################################################################################