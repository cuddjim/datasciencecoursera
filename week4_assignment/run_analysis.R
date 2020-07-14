library(tidyverse);library(magrittr);library(janitor)

path = "C:/Users/jimmy/OneDrive/Documents/repos/datasciencecoursera/week4_assignment/UCI HAR Dataset/"


desc <- list.files(path = path, pattern = '*.txt', full.names = T) %>% 
  lapply(read.table, fill = T)
names(desc) <- tolower(list.files(path = path, pattern = '*.txt') %>% gsub('.txt','',.))
test <- list.files(path = paste0(path,'test/'), pattern = '*.txt', full.names = T) %>% 
  lapply(read.table)
names(test) <- tolower(list.files(path = paste0(path,'test/'), pattern = '*.txt') %>% gsub('.txt','',.))
train <- list.files(path = paste0(path,'train/'), pattern = '*.txt', full.names = T) %>% 
  lapply(read.table)
names(train) <- tolower(list.files(path = paste0(path,'train/'), pattern = '*.txt') %>% gsub('.txt','',.))

features <- desc[["features"]] %>% set_colnames(c('n','functions'))
activities <- desc[["activity_labels"]] %>% set_colnames(c('code','activity'))
subject_test <- test[["subject_test"]] %>% set_colnames(c('subject'))
x_test <- test[["x_test"]] %>% set_colnames(features$functions) %>% clean_names()
y_test <- test[["y_test"]] %>% set_colnames('code')
subject_train <- train[["subject_train"]] %>% set_colnames(c('subject'))
x_train <- train[["x_train"]] %>% set_colnames(features$functions) %>% clean_names()
y_train <- train[["y_train"]] %>% set_colnames('code')


# step 1
x <- bind_rows(x_test,x_train)
y <- bind_rows(y_test,y_train)
subject <- bind_rows(subject_test,subject_train)
all_data <- bind_cols(subject,y,x)

# step 2, 3
all_mean_std <- all_data %>% left_join(activities, by = 'code') %>% select(subject, activity, matches('mean|std'))

# step 4
gather_chg <- data.frame(a = names(all_mean_std)) %>% 
  mutate(a = gsub('^t','time',a),
         a = gsub('^f','frequency',a),
         a = gsub('acc','acceleration',a),
         a = gsub('gyro','gyroscope',a),
         a = gsub('body_body','body',a),
         a = gsub('mag','magnitude',a))
names(all_mean_std) <- gather_chg$a

# step 5
averages <- all_mean_std %>% group_by(subject, activity) %>% summarise_all(list(~mean(.,na.rm = T)))
write.table(averages, 'C:/Users/jimmy/OneDrive/Documents/repos/datasciencecoursera/week4_assignment/final_data.txt', row.names = F)

