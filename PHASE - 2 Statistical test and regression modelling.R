library(readxl)

# 1. Store the FILE PATH, not the Excel data
file_path <- "C:/Users/bhima/Downloads/Banking_Intelligence_Modified.xlsx"

# 2. See all sheet names
excel_sheets(file_path)

# 3. Read all sheets
all_sheets <- lapply(excel_sheets(file_path), function(sheet) {
  read_excel(file_path, sheet = sheet)
})

# 4. Give each dataframe its sheet name
names(all_sheets) <- excel_sheets(file_path)

# 5. Check sheet names
names(all_sheets)

# 6. Create separate dataframes in your environment
list2env(all_sheets, envir = .GlobalEnv)
View(Customers)
View(Branches)
View(rm)
View(Leads)
View(accounts)
View(Transactions)
View(Sales_Targets)
View(Campaign)

#Objective 1 :Test whether Lead Source and CASA Conversion are statistically associated.
#Chisqure test.
conti1 = table(Leads$source, Leads$converted)
conti1

chtest1 = chisq.test(conti1)
chtest1
chtest1$statistic
chtest1$p.value
chtest1$parameter

#Objective 2 :Does annual income differ significantly between customers who converted and those who did not convert?
summary(Customers)
library(dplyr)

test_data <- Leads %>%
  select(customer_id, converted) %>%
  left_join(Customers %>% select(customer_id, annual_income),
            by = "customer_id")

test_data %>%
  group_by(converted) %>%
  summarise(
    n = n(),
    mean_income = mean(annual_income),
    median_income = median(annual_income)
  )
shapiro.test(Customers$annual_income[Leads$converted == 0])
shapiro.test(Customers$annual_income[Leads$converted == 1])

wilcox.test(annual_income ~ converted,
            data = test_data,
            exact = FALSE)


#Objective 3: To determine whether credit score differs significantly between converted and non-converted customers.
test_data_credit <- Leads %>%
  select(customer_id, converted) %>%
  left_join(
    Customers %>% select(customer_id, credit_score),
    by = "customer_id"
  )
head(test_data_credit)
table(test_data_credit$converted)
test_data_credit %>%
  group_by(converted) %>%
  summarise(
    n = n(),
    mean_credit_score = mean(credit_score),
    median_credit_score = median(credit_score)
  )

shapiro.test(test_data_credit$credit_score[test_data_credit$converted == 0])
shapiro.test(test_data_credit$credit_score[test_data_credit$converted == 1])

wilcox.test(
  credit_score ~ converted,
  data = test_data_credit,
  exact = FALSE
)


#Objective 4 :To determine whether salary account status is associated with CASA conversion.
library(dplyr)

test_salary <- Leads %>%
  select(customer_id, converted) %>%
  left_join(
    Customers %>% select(customer_id, salary_account),
    by = "customer_id"
  )

head(test_salary)

conti_salary <- table(
  Salary_Account = test_salary$salary_account,
  Conversion = test_salary$converted
)

conti_salary
chi_salary <- chisq.test(conti_salary)

chi_salary


#Objective 5:To determine whether Relation manger is associated with CASA conversion.
conti_rm <- table(
  RM = Leads$rm_id,
  Conversion = Leads$converted
)

conti_rm
chi_rm <- chisq.test(conti_rm)

chi_rm


#Objective 6:To determine whether Occupation is associated with CASA conversion.
conti_occupation <- table(
  Occupation = Leads %>%
    left_join(
      Customers %>% select(customer_id, occupation),
      by = "customer_id"
    ) %>%
    pull(occupation),
  Conversion = Leads$converted
)
conti_occupation

chi_occupation <- chisq.test(conti_occupation)
chi_occupation

data <- merge(Leads, Customers, by = "customer_id")
plot(data$age, data$converted,
     main = "Age vs Conversion",
     xlab = "Age",
     ylab = "Conversion")
plot(data$credit_score, data$converted,
     main = "Credit Score vs Conversion",
     xlab = "Credit Score",
     ylab = "Conversion")
plot(data$annual_income, data$converted,
     main = "Annual Income vs Conversion",
     xlab = "Annual Income",
     ylab = "Conversion")


reg_data <- Leads %>%
  left_join(
    Customers,
    by = "customer_id"
  ) %>%
  left_join(
    rm,
    by = "rm_id"
  )

names(reg_data)

reg_data <- reg_data %>%
  mutate(
    converted = as.factor(converted),
    gender = as.factor(gender),
    occupation = as.factor(occupation),
    salary_account = as.factor(salary_account),
    source = as.factor(source)
  )
logit_model <- glm(
  converted ~ age + gender + occupation + annual_income +
    salary_account + credit_score + source + experience_years,
  data = reg_data,
  family = binomial
)

summary(logit_model)
library(car)
vif(logit_model)
anova(logit_model, test = "Chisq")
exp(coef(logit_model))
pred_prob <- predict(logit_model, type = "response")

pred_class <- ifelse(pred_prob >= 0.5, 1, 0)

table(
  Actual = reg_data$converted,
  Predicted = pred_class
)


library(car)
data2 <- merge(data, rm, by = "rm_id")
model34 = boxTidwell(converted ~ age + annual_income + credit_score + experience_years,
           data = data2)
summary(model34)

