# Which courts charge the most people aged 17-25?
# Create sub df with defendants age at incident == 17-25
# Include court name, sentence judge, sentencing info, dates
getwd()

setwd("C:\\Users\\16306\\OneDrive\\Desktop\\Personal DA Projects\\Hacking4Justice - 2023 workshop")
sentence_df <- read.csv("Sentencing.csv", header = T)

names(sentence_df) <- tolower(names(sentence_df))

names(sentence_df)

keepers <- c("case_id", "case_participant_id", "disposition_charged_offense_title",
             "charge_disposition","charge_disposition_reason","sentence_judge",
             "sentence_court_facility", "sentence_date", "sentence_type",
             "commitment_type", "commitment_term", "commitment_unit",
             "age_at_incident", "race", "gender")         

sentence_df <- sentence_df[, keepers]

sentence_df <- subset(sentence_df, sentence_df$age_at_incident <= 25)

# Filter out any sentence that is not a guilty verdict
unique(sentence_df$charge_disposition)

guilty_verdicts <- unique(sentence_df$charge_disposition)[c(1,2,4,7,11,14,17,19,20)]
guilty_verdicts

sentence_df <- subset(sentence_df, sentence_df$charge_disposition %in% guilty_verdicts)

# Sort by court name value counts (table)
sub_court_sentence_freq <- data.frame(table(sentence_df$sentence_court_facility))

#COURT NAME FACTORS #levels(sub_court_sentence_freq$Var1)
#REVEALS blank row is actual an empty string with level of 1. 
#The value will remain in the dataset for further exploration.

# Tidy up the results and export to csv for visualization in Tableau
sub_court_sentence_freq <- sub_court_sentence_freq[with(sub_court_sentence_freq, order(-Freq)), ]

colnames(sub_court_sentence_freq)<- c("Sentencing Court", "Number of Convictions, defendants aged 17-25")

?write.csv

write.csv(sub_court_sentence_freq, file = "Court Sentencing Frequency.csv")

# ADDITIONAL QUESTIONS
# What are the sentences passed down from those courts?

# BONUS1: How have these trends changed over time?

# BONUS2: Of these courts, which judges are more likely to pass harsher sentences?