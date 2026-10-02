Lean Six Sigma CASA Banking Analytics

A Lean Six Sigma DMAIC-based retail banking analytics project focused on CASA lead conversion, statistical analysis, machine-learning lead prioritization, and Power BI process monitoring using simulated banking data.

Project Overview

Retail banks receive many CASA leads, but Relationship Managers (RMs) have limited time. This project builds an analytics framework to understand which leads are more likely to convert, which factors are linked with conversion, and how performance can be monitored over time.

The project follows the DMAIC framework:

Define → Measure → Analyze → Improve → Control

Business Problem

The bank has customer, lead, RM, branch, campaign, account, transaction, and target data, but does not have one integrated system to:

Measure CASA conversion
Identify factors linked with conversion
Prioritize leads for RM attention
Monitor branch and campaign performance
Track the process using a control dashboard
Objectives
Measure the current CASA lead conversion rate.
Identify statistically significant factors associated with conversion.
Build ML models to rank leads by conversion probability.
Create High, Medium, and Low lead-priority groups.
Develop a Power BI dashboard for monitoring.
Create a Lean Six Sigma control plan for continuous monitoring.
Methodology
Define
Project charter
Business problem
VOC/VOB
CTQ definition
SIPOC
Process scope
Defect definition

Primary CTQ: CASA Lead Conversion Rate

Measure
Data-quality checks
Baseline conversion calculation
Monthly analysis
Lead-source analysis
Customer-level descriptive analysis

Baseline:

Total leads: 1,000
Converted leads: 653
Non-converted leads: 347
Conversion rate: 65.3%
95% Wilson CI: 62.3%–68.2%
Analyze

Statistical methods used:

Chi-square test
Shapiro-Wilk test
Wilcoxon rank-sum test
Binary logistic regression
Likelihood-ratio test
VIF/GVIF

The analysis found statistically significant associations with:

Salary-account status
Annual income
Credit score
Age
RM experience

Lead source, occupation, gender, and RM identity were not statistically significant in the final analysis.

Salary-account status had an adjusted odds ratio of about 1.99, meaning customers with a salary account had about twice the odds of conversion after adjusting for the other variables. This is an association, not proof of causation.

Improve

Three ML models were compared:

Random Forest
XGBoost
LightGBM

Model evaluation used 5-fold cross-validation and ROC-AUC.

Model	Test ROC-AUC	Accuracy
Random Forest	0.604	57.0%
XGBoost	0.589	59.5%
LightGBM	0.573	61.5%

Random Forest was selected based on the project's ROC-AUC selection rule. Its cross-validation AUC was 0.672 and held-out AUC was 0.604.

Because the predictive performance is limited, the model is treated as a lead-prioritization decision-support tool, not an automatic decision-making system.

Lead Priority

The predicted probabilities were grouped into three bands:

Priority	Rule	Leads	Share
High	≥ 0.70	108	10.8%
Medium	0.40–<0.70	595	59.5%
Low	< 0.40	297	29.7%

These cut-offs are project-defined and require validation before real-world use.

Control

A Power BI Retail Banking Intelligence & Control Dashboard was developed to monitor:

Total leads
Converted leads
Non-converted leads
CASA conversion rate
Monthly conversion trend
Lead-priority distribution
Conversion by priority
Branch performance
Campaign performance
Data and model monitoring

A control plan was also created with monitoring frequency, ownership, triggers, and reaction actions.

Key Findings
Overall CASA conversion rate was 65.3%.
Monthly conversion rates ranged from about 63% to 68%.
There was no statistically significant difference in conversion across the three months.
Salary-account status, income, credit score, age, and RM experience showed statistical associations with conversion.
Lead source did not show a statistically significant relationship with conversion.
ML models showed only limited predictive power.
The project supports lead prioritization, not automatic approval or rejection.
Tools & Technologies
Python: pandas, scikit-learn, XGBoost, LightGBM
R: dplyr, car, readxl
SQL: data analysis and integration concepts
Power BI Desktop: dashboard and monitoring
Excel: data preparation and analysis
Lean Six Sigma: DMAIC, CTQ, SIPOC, control plan
Dataset

The project uses a synthetic retail banking dataset containing:

1,000 customers
1,000 leads
30 Relationship Managers
10 branches
January–March 2026 data
CASA accounts
Transactions
Sales targets
Campaign history

The data are simulated and are used to demonstrate the analytical methodology rather than represent real bank customers or real banking performance.

Project Structure
lean-six-sigma-casa-banking-analytics/
│
├── data/
│   └── Banking_Intelligence_Modified.xlsx
│
├── notebooks/
│   ├── Phase_1_EDA
│   ├── Phase_2_Statistical_Analysis
│   └── Phase_3_Machine_Learning
│
├── powerbi/
│   └── CASA_DESKSTOP_PRO.pbix
│
├── reports/
│   └── CASA_Lean_Six_Sigma_Integrated_Project_Report.pdf
│
├── outputs/
│   └── ML_Lead_Priority.xlsx
│
└── README.md
Important Limitations

This project demonstrates the method and analytical workflow, but it does not prove:

Real-bank improvement
Causal relationships
ROI
Production-ready ML performance
Sustained Six Sigma improvement

The dataset is synthetic, the observation period is only three months, and no real controlled experiment was performed.

Final Outcome

The project combines:

Lean Six Sigma + Statistical Testing + Logistic Regression + Machine Learning + Power BI

to create a complete retail banking analytics framework for CASA conversion measurement, lead prioritization, and process monitoring.
