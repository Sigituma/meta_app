library(shiny)
library(DT)
library(meta)
library(grid)
library(shinyjs)

# Définir les noms de colonnes
colonnes <- c("Study", "n.e", "mean.e", "sd.e", "n.c", "mean.c", "sd.c", "Delete")
colonnes_cate <- c("Study", "event.e", "n.e", "event.c", "n.c", "Delete")

# Créer des tables de données vides avec les noms de colonnes
donnees_initiales <- data.frame(matrix(NA, ncol = length(colonnes), nrow = 0))
colnames(donnees_initiales) <- colonnes

donnees_initiales_cate <- data.frame(matrix(NA, ncol = length(colonnes_cate), nrow = 0))
colnames(donnees_initiales_cate) <- colonnes_cate

# Définir l'interface utilisateur
ui <- fluidPage(
  useShinyjs(),  # Initialiser shinyjs pour permettre le contrôle de la visibilité
  # Ajouter une div pour les logos
  div(style = "text-align: left; padding: 10px;",
      img(src = "cnrs.png", height = "50px"),
      img(src = "le-vinatier-psychiatrie-universitaire-lyon-metropole-6381-logo.png", height = "50px")
  ),
  #############PARTIE META ANALYSE CONTINUE#############
  ######################################################
  ######################################################
  ######################################################
  ui <- navbarPage("Meta Analysis App",
                   tabPanel("Home",
                            fluidPage(
                              tags$head(
                                tags$style(HTML("
                              .header-panel {
                                background-color: #f5f5dc; /* beige background */
                                border: 2px solid #2A1B3D; /* dark border */
                                padding: 10px;
                                border-radius: 10px;
                                margin-top: 50px;
                                margin-bottom: 50px;
                                text-align: center;
                              }
                              .content {
                                margin: 20px;
                                text-align: center; /* Center text */
                              }
                              .section {
                                border: 1px solid #2A1B3D; /* dark border */
                                padding: 20px;
                                border-radius: 5px;
                                margin-bottom: 20px;
                                box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
                                display: flex;
                                flex-direction: column;
                                align-items: center;
                              }
                              .section1 {
                                background-color: #D83F87; /* pink */
                              }
                              .section2 {
                                background-color: #2A1B3D; /* dark purple */
                              }
                              .section3 {
                                background-color: #44318D; /* blue */
                              }
                              .section4 {
                                background-color: #E98074; /* light coral */
                              }
                              .section5 {
                                background-color: #A4B3B6; /* light grey */
                              }
                              .section h3, .section h4 {
                                color: #ffffff; /* white for headings */
                              }
                              .section p, .section li {
                                color: #ffffff; /* white for text */
                                text-align: center;
                              }
                              .section ul {
                                text-align: left;
                                padding-left: 20px;
                              }
                            "))
                              ),
                              div(class = "header-panel",
                                  titlePanel("Welcome to the Meta Analysis Application, an open source app.")
                              ),
                              div(class = "content",
                                  div(class = "section section1",
                                      h3("Welcome"),
                                      p("This application allows you to perform meta-analyses on different types of data.")
                                  ),
                                  div(class = "section section2",
                                      h4("Sections:"),
                                      p("1. Continuous Outcomes: Perform meta-analysis on continuous data."),
                                      p("2. Categorical Outcomes: Perform meta-analysis on categorical data."),
                                      p("3. Incidence Rates: Perform meta-analysis on incidence rates."),
                                      p("4. Correlations: Perform meta-analysis on correlation data."),
                                      p("5. Single Means: Perform meta-analysis on single means."),
                                      p("6. Single Proportions: Perform meta-analysis on single proportions."),
                                      p("7. Single Incidence Rates: Perform meta-analysis on single incidence rates.")
                                  ),
                                  div(class = "section section3",
                                      h3("Tutorial: How to Perform a Meta-Analysis"),
                                      p("Follow these steps to perform a meta-analysis:"),
                                      h4("Step 1: Select the Appropriate Section"),
                                      p("Choose the type of data you want to analyze from the navigation bar above."),
                                      h4("Step 2: Upload Your Data"),
                                      p("Each section has a file input field where you can upload your data in CSV format."),
                                      p("Ensure your CSV file contains the necessary columns as specified in each section."),
                                      h4("Step 3: Add Studies Manually (Optional)"),
                                      p("You can add studies manually by clicking the 'Add a study manually' button and filling in the details."),
                                      h4("Step 4: Choose Analysis Options"),
                                      p("Select the effect measure, bias test, and whether you want to use a fixed or random effects model."),
                                      p("You can also choose to perform subgroup analysis if applicable."),
                                      h4("Step 5: Perform the Meta-Analysis"),
                                      p("Click the 'Perform meta-analysis' button to run the analysis."),
                                      h4("Step 6: Review and Download Results"),
                                      p("The results of the meta-analysis will be displayed in various tabs:"),
                                      tags$ul(
                                        tags$li("Meta-analysis result: View the textual results of the analysis."),
                                        tags$li("Forest plot: View and download the forest plot."),
                                        tags$li("Funnel plot: View and download the funnel plot."),
                                        tags$li("Publication bias test: View the results of the publication bias test."),
                                        tags$li("Trim and Fill: View and download the forest plot after trim and fill adjustments.")
                                      ),
                                      br(),
                                      h4("Download Example Data"),
                                      p("Download example CSV files for each type of meta-analysis:"),
                                      downloadButton("downloadExampleContinuous", "Continuous Outcomes Example"),
                                      br(), br(),
                                      downloadButton("downloadExampleCategorical", "Categorical Outcomes Example"),
                                      br(), br(),
                                      downloadButton("downloadExampleIncidence", "Incidence Rates Example"),
                                      br(), br(),
                                      downloadButton("downloadExampleCorrelations", "Correlations Example"),
                                      br(), br(),
                                      downloadButton("downloadExampleSingleMeans", "Single Means Example"),
                                      br(), br(),
                                      downloadButton("downloadExampleSingleProportions", "Single Proportions Example"),
                                      br(), br(),
                                      downloadButton("downloadExampleSingleIncidence", "Single Incidence Rates Example")
                                  ),
                                  div(class = "section section4",
                                      h3("Enjoy Your Analysis"),
                                      p("Feel free to explore different sections and analyze your data. Happy analyzing!"),
                                      br(),
                                      h3("This application is open source, and all contributions are welcome.")
                                  )
                              )
                            )
                   ),
                   ###############Partie meta analyse valeurs continue###############
                   #######################################################################
                   #######################################################################
                   #######################################################################
             tabPanel("Continuous Outcomes",
                      fluidPage(
                        div(style = "text-align: center; margin-top: 50px; margin-bottom: 50px;",
                            div(style = "display: inline-block; border: 2px solid blue; padding: 10px; border-radius: 10px;",
                                titlePanel("Meta analysis of continuous outcomes")
                            )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            br(),
                            # Champ pour télécharger un fichier CSV
                            fileInput("fichierCSV", "Upload the CSV file:",
                                      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                            br(),
                            # Bouton pour plier/déplier la section de saisie manuelle
                            actionButton("toggleInputs", "Add a study manually", class = "btn btn-primary"),
                            br(),
                            # Section de saisie manuelle pliable/dépliable
                            div(id = "inputSection",
                                style = "display: none;",  # Initialement caché
                                textInput("StudyInput", "Study:"),
                                textInput("SubgroupInput", "Subgroup:"),
                                numericInput("nsczInput", "n.e:", NA),
                                numericInput("meanSczInput", "mean.e:", NA),
                                numericInput("sdSczInput", "sd.e:", NA),
                                numericInput("nctrlInput", "n.c:", NA),
                                numericInput("meanCtrlInput", "mean.c:", NA),
                                numericInput("sdCtrlInput", "sd.c:", NA),
                                actionButton("ajouterEtude", "Ajouter étude")
                            )
                          ),
                          
                          mainPanel(
                            # Ajouter une description pour le fichier CSV dans un cadre à fond bleu
                            div(style = "background-color: #e6f7ff; border: 1px solid #b3d9ff; padding: 15px; border-radius: 5px;",
                                p(HTML("<b>The CSV file must contain at least the following columns: 'Study', 'n.e', 'mean.e', 'sd.e', 'n.c', 'mean.c', 'sd.c'. The 'Subgroup' column is optional. Ensure that the column names match exactly those indicated.</b>")),
                                br(),
                                p("You can also modify your data directly in the table by double-clicking on the element that needs modification.")
                            ),
                            br(),
                            # Afficher la table de données
                            DTOutput("tableau"),
                            # Créer une rangée pour les sélections côte à côte
                            fluidRow(
                              column(4,
                                     # Sélection de la mesure d'effet
                                     selectInput("effectMeasure", "Effect measure:",
                                                 choices = c("MD", "SMD", "ROM"))
                              ),
                              column(4,
                                     # Sélection du test de biais
                                     selectInput("biastest", "Bias test:",
                                                 choices = c("Begg", "Egger", "Thompson")),

                              ),
                              column(4,
                                     # Bouton de sélection pour les modèles à effets aléatoires
                                     checkboxInput("randomEffectsModel", "Random Effects Model", value = TRUE),
                                     # Bouton de sélection pour les modèles à effets fixes
                                     checkboxInput("fixedEffectsModel", "Fixed Effects Model", value = TRUE),
                                     # Bouton de sélection pour l'analyse de sous-groupes
                                     checkboxInput("performSubgroupAnalysis", "Subgroup Analysis", value = FALSE)
                              )
                            ),
                            br(),
                            # Bouton pour réaliser la méta-analyse
                            actionButton("realiserMetaAnalyse", "Perform meta-analysis"),
                            br(),
                            br(),
                            # Panneaux pour afficher les résultats et les graphiques
                            tabsetPanel(
                              tabPanel("Meta-analysis result", 
                                       verbatimTextOutput("metaResultText"),
                                       downloadButton("downloadMetaResult", "Download Meta-Analysis Results", style = "margin-bottom: 20px;")),
                              tabPanel("Forest plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadForestPlot", "Download Forest Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;", # Center-align the content
                                         imageOutput("forestPlotImage")
                                       )
                              ),
                              tabPanel("Funnel plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                       downloadButton("downloadFunnelPlot", "Download Funnel Plot")
                                                      ),
                                       div(
                                         style = "width: 700px; height: 720px;",
                                         imageOutput("funnelPlotImage")
                                       )),
                              tabPanel("Publication bias test", 
                                       verbatimTextOutput("pubbiastext"),
                                       downloadButton("downloadBiasTest", "Download Bias Test Results", style = "margin-bottom: 20px;")),
                              tabPanel("Trim and Fill",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadtrimandfillforest", "Download Forest Plot Trim and Fill")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("foresttrimandfillImage")
                                       ))
                            )
                          )
                        )
                      )
             ),
             ###############Partie meta analyse valeurs catégorielles###############
             #######################################################################
             #######################################################################
             #######################################################################
             tabPanel("Categorical Outcomes",
                      fluidPage(
                        div(style = "text-align: center; margin-top: 50px; margin-bottom: 50px;",
                            div(style = "display: inline-block; border: 2px solid green; padding: 10px; border-radius: 10px;",
                                titlePanel("Meta analysis of categorical outcomes")
                            )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            br(),
                            # Champ pour télécharger un fichier CSV
                            fileInput("fichierCSV_cate", "Upload the CSV file:",
                                      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                            br(),
                            # Bouton pour plier/déplier la section de saisie manuelle
                            actionButton("toggleInputs_cate", "Add a study manually", class = "btn btn-primary"),
                            br(),
                            # Section de saisie manuelle pliable/dépliable
                            div(id = "inputSection_cate",
                                style = "display: none;",  # Initialement caché
                                textInput("studyInput", "Study:"),
                                textInput("subgroup_cat", "Subgroup: "),
                                numericInput("eventeInput", "event.e:", NA),
                                numericInput("neInput", "n.e:", NA),
                                numericInput("eventcInput", "event.c:", NA),
                                numericInput("ncInput", "n.c:", NA),
                                actionButton("ajouterEtude_cate", "Ajouter étude")
                            )
                          ),
                          mainPanel(
                            # Ajouter une description pour le fichier CSV dans un cadre à fond bleu
                            div(style = "background-color: #e6f7ff; border: 1px solid #b3d9ff; padding: 15px; border-radius: 5px;",
                                p(HTML("<b>The CSV file must contain the following columns: 'Study', 'event.e', 'n.e', 'event.c', 'n.c'.  The 'Subgroup' column is optional. Ensure that the column names match exactly those indicated.</b>")),
                                br(),
                                p("You can also modify your data directly in the table by double-clicking on the element that needs modification.")
                            ),
                            br(),
                            # Afficher la table de données
                            DTOutput("tableau_cate"),
                            # Créer une rangée pour les sélections côte à côte
                            fluidRow(
                              column(4,
                                     # Sélection de la mesure d'effet
                                     selectInput("effectMeasure_cate", "Effect measure:",
                                                 choices = c("RR", "OR", "RD", "ASD", "DOR", "VE"))
                              ),
                              column(4,
                                     # Sélection du test de biais
                                     selectInput("biastest_cate", "Bias test:",
                                                 choices = c("Begg", "Egger", "Thompson"))
                              ),
                              column(4,
                                     # Bouton de sélection pour les modèles à effets aléatoires
                                     checkboxInput("randomEffectsModel_cate", "Random Effects Model", value = TRUE),
                                     # Bouton de sélection pour les modèles à effets fixes
                                     checkboxInput("fixedEffectsModel_cate", "Fixed Effects Model", value = TRUE),
                                     # Bouton de sélection pour l'analyse de sous-groupes
                                     checkboxInput("performSubgroupAnalysis_cate", "Subgroup Analysis", value = FALSE)
                              )
                            ),
                            br(),
                            # Bouton pour réaliser la méta-analyse
                            actionButton("realiserMetaAnalyse_cate", "Perform meta-analysis"),
                            br(),
                            br(),
                            # Panneaux pour afficher les résultats et les graphiques
                            tabsetPanel(
                              tabPanel("Meta-analysis result", 
                                       verbatimTextOutput("metaResultText_cate"),
                                       downloadButton("downloadMetaResult_cate", "Download Meta-Analysis Results", style = "margin-bottom: 20px;")),
                              tabPanel("Forest plot", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadForestPlot_cate", "Download Forest Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;", # Center-align the content
                                         imageOutput("forestPlotImage_cate")
                                       )
                              ),
                              tabPanel("Funnel plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadFunnelPlot_cate", "Download Funnel Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("funnelPlotImage_cate")
                                       )),
                              tabPanel("Publication bias test", 
                                       verbatimTextOutput("pubbiastext_cate"),
                                       downloadButton("downloadBiasTest_cate", "Download Bias Test Results", style = "margin-bottom: 20px;")),
                              tabPanel("Trim and Fill", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadtrimandfillforest_cate", "Download Forest Plot Trim and Fill")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("foresttrimandfillImage_cate")
                                       ))
                            )
                          )
                        )
                      )
             )
             ,
             ###############Meta-analysis of incidence rates###############
             #######################################################################
             #######################################################################
             #######################################################################
             tabPanel("Incidence Rates",
                      fluidPage(
                        div(style = "text-align: center; margin-top: 50px; margin-bottom: 50px;",
                            div(style = "display: inline-block; border: 2px solid orange; padding: 10px; border-radius: 10px;",
                                titlePanel("Meta-analysis of incidence rates")
                            )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            br(),
                            # Field to upload a CSV file
                            fileInput("fichierCSV_incidence", "Upload the CSV file:",
                                      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                            br(),
                            # Button to toggle the manual input section
                            actionButton("toggleInputs_incidence", "Add a study manually", class = "btn btn-primary"),
                            br(),
                            # Collapsible/expandable manual input section
                            div(id = "inputSection_incidence",
                                style = "display: none;",  # Initially hidden
                                textInput("studyInput_incidence", "Study:"),
                                textInput("subgroup_incidence", "Subgroup: "),
                                numericInput("eventeINCInput", "Event Count (Experimental):", NA),
                                numericInput("timeeINCInput", "Person Years (Experimental):", NA),
                                numericInput("eventcINCInput", "Event Count (Control):", NA),
                                numericInput("timecINCInput", "Person Years (Control):", NA),
                                actionButton("ajouterEtude_incidence", "Add Study")
                            )
                          ),
                          mainPanel(
                            # Adding a description for the CSV file in a blue box
                            div(style = "background-color: #e6f7ff; border: 1px solid #b3d9ff; padding: 15px; border-radius: 5px;",
                                p(HTML("<b>The CSV file must contain the following columns: 'Study', 'Event Count (Experimental)', 'Person Years (Experimental)', 'Event Count (Control)', 'Person Years (Control)'.  The 'Subgroup' column is optional. Ensure that the column names match exactly those indicated.</b>")),
                                br(),
                                p("You can also modify your data directly in the table by double-clicking on the element that needs modification.")
                            ),
                            br(),
                            # Display the data table
                            DTOutput("tableau_incidence"),
                            # Creating a row for selections side by side
                            fluidRow(
                              column(4,
                                     # Effect measure selection
                                     selectInput("effectMeasure_incidence", "Effect measure:",
                                                 choices = c("IRR", "IRD", "IRSD", "VE"))
                              ),
                              column(4,
                                     # Bias test selection
                                     selectInput("biastest_incidence", "Bias test:",
                                                 choices = c("Begg", "Egger", "Thompson"))
                              ),
                              column(4,
                                     # Checkbox for random effects model
                                     checkboxInput("randomEffectsModel_incidence", "Random Effects Model", value = TRUE),
                                     # Checkbox for fixed effects model
                                     checkboxInput("fixedEffectsModel_incidence", "Fixed Effects Model", value = TRUE),
                                     # Checkbox for subgroup analysis
                                     checkboxInput("performSubgroupAnalysis_incidence", "Subgroup Analysis", value = FALSE)
                              )
                            ),
                            br(),
                            # Button to perform the meta-analysis
                            actionButton("realiserMetaAnalyse_incidence", "Perform meta-analysis"),
                            br(),
                            br(),
                            # Tabs to display results and plots
                            tabsetPanel(
                              tabPanel("Meta-analysis result", 
                                       verbatimTextOutput("metaResultText_incidence"),
                                       downloadButton("downloadMetaResult_incidence", "Download Meta-Analysis Results", style = "margin-bottom: 20px;")),
                              tabPanel("Forest plot", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadForestPlot_incidence", "Download Forest Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;", # Center-align the content
                                         imageOutput("forestPlotImage_incidence")
                                       )
                              ),
                              tabPanel("Funnel plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadFunnelPlot_incidence", "Download Funnel Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("funnelPlotImage_incidence")
                                       )),
                              tabPanel("Publication bias test", 
                                       verbatimTextOutput("pubbiastext_incidence"),
                                       downloadButton("downloadBiasTest_incidence", "Download Bias Test Results", style = "margin-bottom: 20px;")),
                              tabPanel("Trim and Fill", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadtrimandfillforest_incidence", "Download Forest Plot Trim and Fill")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("foresttrimandfillImage_incidence")
                                       ))
                            )
                          )
                        )
                      )
             ),
             ###############Meta-analysis of correlations###############
             #######################################################################
             #######################################################################
             #######################################################################
             tabPanel("Correlations",
                      fluidPage(
                        div(style = "text-align: center; margin-top: 50px; margin-bottom: 50px;",
                            div(style = "display: inline-block; border: 2px solid purple; padding: 10px; border-radius: 10px;",
                                titlePanel("Meta-analysis of correlations")
                            )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            br(),
                            # Field to upload a CSV file
                            fileInput("fichierCSV_correlation", "Upload the CSV file:",
                                      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                            br(),
                            # Button to toggle the manual input section
                            actionButton("toggleInputs_correlation", "Add a study manually", class = "btn btn-primary"),
                            br(),
                            # Collapsible/expandable manual input section
                            div(id = "inputSection_correlation",
                                style = "display: none;",  # Initially hidden
                                textInput("studyInput_correlation", "Study:"),
                                textInput("subgroup_correlation", "Subgroup: "),
                                numericInput("correlationInput", "Correlation (r):", NA),
                                numericInput("n_correlation", "Sample size (n):", NA),
                                actionButton("ajouterEtude_correlation", "Add Study")
                            )
                          ),
                          mainPanel(
                            # Adding a description for the CSV file in a blue box
                            div(style = "background-color: #e6f7ff; border: 1px solid #b3d9ff; padding: 15px; border-radius: 5px;",
                                p(HTML("<b>The CSV file must contain the following columns: 'Study', 'Correlation', 'Sample size'.  The 'Subgroup' column is optional. Ensure that the column names match exactly those indicated.</b>")),
                                br(),
                                p("You can also modify your data directly in the table by double-clicking on the element that needs modification.")
                            ),
                            br(),
                            # Display the data table
                            DTOutput("tableau_correlation"),
                            # Creating a row for selections side by side
                            fluidRow(
                              column(4,
                                     # Effect measure selection
                                     selectInput("effectMeasure_correlation", "Effect measure:",
                                                 choices = c("ZCOR", "COR"))
                              ),
                              column(4,
                                     # Bias test selection
                                     selectInput("biastest_correlation", "Bias test:",
                                                 choices = c("Begg", "Egger", "Thompson"))
                              ),
                              column(4,
                                     # Checkbox for random effects model
                                     checkboxInput("randomEffectsModel_correlation", "Random Effects Model", value = TRUE),
                                     # Checkbox for fixed effects model
                                     checkboxInput("fixedEffectsModel_correlation", "Fixed Effects Model", value = TRUE),
                                     # Checkbox for subgroup analysis
                                     checkboxInput("performSubgroupAnalysis_correlation", "Subgroup Analysis", value = FALSE)
                              )
                            ),
                            br(),
                            # Button to perform the meta-analysis
                            actionButton("realiserMetaAnalyse_correlation", "Perform meta-analysis"),
                            br(),
                            br(),
                            # Tabs to display results and plots
                            tabsetPanel(
                              tabPanel("Meta-analysis result", 
                                       verbatimTextOutput("metaResultText_correlation"),
                                       downloadButton("downloadMetaResult_correlation", "Download Meta-Analysis Results", style = "margin-bottom: 20px;")),
                              tabPanel("Forest plot", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadForestPlot_correlation", "Download Forest Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;", # Center-align the content
                                         imageOutput("forestPlotImage_correlation")
                                       )
                              ),
                              tabPanel("Funnel plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadFunnelPlot_correlation", "Download Funnel Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("funnelPlotImage_correlation")
                                       )),
                              tabPanel("Publication bias test", 
                                       verbatimTextOutput("pubbiastext_correlation"),
                                       downloadButton("downloadBiasTest_correlation", "Download Bias Test Results", style = "margin-bottom: 20px;")),
                              tabPanel("Trim and Fill", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadtrimandfillforest_correlation", "Download Forest Plot Trim and Fill")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("foresttrimandfillImage_correlation")
                                       ))
                            )
                          )
                        )
                      )
             ),
             #######################SINGLE MEAN##############################
             ################################################################
             ################################################################
             ################################################################
             tabPanel("Single means",
                      fluidPage(
                        div(style = "text-align: center; margin-top: 50px; margin-bottom: 50px;",
                            div(style = "display: inline-block; border: 2px solid orange; padding: 10px; border-radius: 10px;",
                                titlePanel("Meta-analysis of single means")
                            )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            br(),
                            # Field to upload a CSV file
                            fileInput("fichierCSV_single_means", "Upload the CSV file:",
                                      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                            br(),
                            # Button to toggle the manual input section
                            actionButton("toggleInputs_single_means", "Add a study manually", class = "btn btn-primary"),
                            br(),
                            # Collapsible/expandable manual input section
                            div(id = "inputSection_single_means",
                                style = "display: none;",  # Initially hidden
                                textInput("studyInput_single_means", "Study:"),
                                textInput("subgroup_single_means", "Subgroup: "),
                                numericInput("nInput_single_means", "Sample size (n):", NA),
                                numericInput("meanInput_single_means", "Mean:", NA),
                                numericInput("sdInput_single_means", "Standard deviation (sd):", NA),
                                actionButton("ajouterEtude_single_means", "Add Study")
                            )
                          ),
                          mainPanel(
                            # Adding a description for the CSV file in a blue box
                            div(style = "background-color: #e6f7ff; border: 1px solid #b3d9ff; padding: 15px; border-radius: 5px;",
                                p(HTML("<b>The CSV file must contain the following columns: 'Study', 'n', 'mean', 'sd'.  The 'Subgroup' column is optional. Ensure that the column names match exactly those indicated.</b>")),
                                br(),
                                p("You can also modify your data directly in the table by double-clicking on the element that needs modification.")
                            ),
                            br(),
                            # Display the data table
                            DTOutput("tableau_single_means"),
                            # Creating a row for selections side by side
                            fluidRow(
                              column(4,
                                     # Effect measure selection
                                     selectInput("effectMeasure_single_means", "Effect measure:",
                                                 choices = c("MRAW", "MLN"))
                              ),
                              column(4,
                                     # Bias test selection
                                     selectInput("biastest_single_means", "Bias test:",
                                                 choices = c("Begg", "Egger", "Thompson"))
                              ),
                              column(4,
                                     # Checkbox for random effects model
                                     checkboxInput("randomEffectsModel_single_means", "Random Effects Model", value = TRUE),
                                     # Checkbox for fixed effects model
                                     checkboxInput("fixedEffectsModel_single_means", "Fixed Effects Model", value = TRUE),
                                     # Checkbox for subgroup analysis
                                     checkboxInput("performSubgroupAnalysis_single_means", "Subgroup Analysis", value = FALSE)
                              )
                            ),
                            br(),
                            # Button to perform the meta-analysis
                            actionButton("realiserMetaAnalyse_single_means", "Perform meta-analysis"),
                            br(),
                            br(),
                            # Tabs to display results and plots
                            tabsetPanel(
                              tabPanel("Meta-analysis result", 
                                       verbatimTextOutput("metaResultText_single_means"),
                                       downloadButton("downloadMetaResult_single_means", "Download Meta-Analysis Results", style = "margin-bottom: 20px;")),
                              tabPanel("Forest plot", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadForestPlot_single_means", "Download Forest Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;", # Center-align the content
                                         imageOutput("forestPlotImage_single_means")
                                       )
                              ),
                              tabPanel("Funnel plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadFunnelPlot_single_means", "Download Funnel Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("funnelPlotImage_single_means")
                                       )),
                              tabPanel("Publication bias test", 
                                       verbatimTextOutput("pubbiastext_single_means"),
                                       downloadButton("downloadBiasTest_single_means", "Download Bias Test Results", style = "margin-bottom: 20px;")),
                              tabPanel("Trim and Fill", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadtrimandfillforest_single_means", "Download Forest Plot Trim and Fill")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("foresttrimandfillImage_single_means")
                                       ))
                            )
                          )
                        )
                      )
             ),
             ###############Partie Meta-analysis of single proportions###############
             #######################################################################
             #######################################################################
             #######################################################################
             tabPanel("Single proportions",
                      fluidPage(
                        div(style = "text-align: center; margin-top: 50px; margin-bottom: 50px;",
                            div(style = "display: inline-block; border: 2px solid teal; padding: 10px; border-radius: 10px;",
                                titlePanel("Meta-analysis of single proportions")
                            )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            br(),
                            # Field to upload a CSV file
                            fileInput("fichierCSV_single_proportions", "Upload the CSV file:",
                                      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                            br(),
                            # Button to toggle the manual input section
                            actionButton("toggleInputs_single_proportions", "Add a study manually", class = "btn btn-primary"),
                            br(),
                            # Collapsible/expandable manual input section
                            div(id = "inputSection_single_proportions",
                                style = "display: none;",  # Initially hidden
                                textInput("studyInput_single_proportions", "Study:"),
                                textInput("subgroup_single_proportions", "Subgroup: "),
                                numericInput("eventInput_single_proportions", "Event count:", NA),
                                numericInput("nInput_single_proportions", "Total count:", NA),
                                actionButton("ajouterEtude_single_proportions", "Add Study")
                            )
                          ),
                          mainPanel(
                            # Adding a description for the CSV file in a blue box
                            div(style = "background-color: #e6f7ff; border: 1px solid #b3d9ff; padding: 15px; border-radius: 5px;",
                                p(HTML("<b>The CSV file must contain the following columns: 'Study', 'Event count', 'Total count'.  The 'Subgroup' column is optional. Ensure that the column names match exactly those indicated.</b>")),
                                br(),
                                p("You can also modify your data directly in the table by double-clicking on the element that needs modification.")
                            ),
                            br(),
                            # Display the data table
                            DTOutput("tableau_single_proportions"),
                            # Creating a row for selections side by side
                            fluidRow(
                              column(4,
                                     # Effect measure selection
                                     selectInput("effectMeasure_single_proportions", "Effect measure:",
                                                 choices = c("PLOGIT", "PAS", "PFT", "PLN", "PRAW"))
                              ),
                              column(4,
                                     # Bias test selection
                                     selectInput("biastest_single_proportions", "Bias test:",
                                                 choices = c("Begg", "Egger", "Thompson"))
                              ),
                              column(4,
                                     # Checkbox for random effects model
                                     checkboxInput("randomEffectsModel_single_proportions", "Random Effects Model", value = TRUE),
                                     # Checkbox for fixed effects model
                                     checkboxInput("fixedEffectsModel_single_proportions", "Fixed Effects Model", value = TRUE),
                                     # Checkbox for subgroup analysis
                                     checkboxInput("performSubgroupAnalysis_single_proportions", "Subgroup Analysis", value = FALSE)
                              )
                            ),
                            br(),
                            # Button to perform the meta-analysis
                            actionButton("realiserMetaAnalyse_single_proportions", "Perform meta-analysis"),
                            br(),
                            br(),
                            # Tabs to display results and plots
                            tabsetPanel(
                              tabPanel("Meta-analysis result", 
                                       verbatimTextOutput("metaResultText_single_proportions"),
                                       downloadButton("downloadMetaResult_single_proportions", "Download Meta-Analysis Results", style = "margin-bottom: 20px;")),
                              tabPanel("Forest plot", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadForestPlot_single_proportions", "Download Forest Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;", # Center-align the content
                                         imageOutput("forestPlotImage_single_proportions")
                                       )
                              ),
                              tabPanel("Funnel plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadFunnelPlot_single_proportions", "Download Funnel Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("funnelPlotImage_single_proportions")
                                       )),
                              tabPanel("Publication bias test", 
                                       verbatimTextOutput("pubbiastext_single_proportions"),
                                       downloadButton("downloadBiasTest_single_proportions", "Download Bias Test Results", style = "margin-bottom: 20px;")),
                              tabPanel("Trim and Fill", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadtrimandfillforest_single_proportions", "Download Forest Plot Trim and Fill")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("foresttrimandfillImage_single_proportions")
                                       ))
                            )
                          )
                        )
                      )
             ),
             ###############Partie Meta-analysis of single incidence rates###############
             ###########################################################################
             ###########################################################################
             ###########################################################################
             tabPanel("Single incidence rates",
                      fluidPage(
                        div(style = "text-align: center; margin-top: 50px; margin-bottom: 50px;",
                            div(style = "display: inline-block; border: 2px solid navy; padding: 10px; border-radius: 10px;",
                                titlePanel("Meta-analysis of single incidence rates")
                            )
                        ),
                        sidebarLayout(
                          sidebarPanel(
                            br(),
                            # Field to upload a CSV file
                            fileInput("fichierCSV_single_incidence_rates", "Upload the CSV file:",
                                      accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv")),
                            br(),
                            # Button to toggle the manual input section
                            actionButton("toggleInputs_single_incidence_rates", "Add a study manually", class = "btn btn-primary"),
                            br(),
                            # Collapsible/expandable manual input section
                            div(id = "inputSection_single_incidence_rates",
                                style = "display: none;",  # Initially hidden
                                textInput("studyInput_single_incidence_rates", "Study:"),
                                textInput("subgroup_single_incidence_rates", "Subgroup: "),
                                numericInput("eventsInput_single_incidence_rates", "Number of events:", NA),
                                numericInput("timeInput_single_incidence_rates", "Person-time:", NA),
                                actionButton("ajouterEtude_single_incidence_rates", "Add Study")
                            )
                          ),
                          mainPanel(
                            # Adding a description for the CSV file in a blue box
                            div(style = "background-color: #e6f7ff; border: 1px solid #b3d9ff; padding: 15px; border-radius: 5px;",
                                p(HTML("<b>The CSV file must contain the following columns: 'Study', 'Number of events', 'Person-time'.  The 'Subgroup' column is optional. Ensure that the column names match exactly those indicated.</b>")),
                                br(),
                                p("You can also modify your data directly in the table by double-clicking on the element that needs modification.")
                            ),
                            br(),
                            # Display the data table
                            DTOutput("tableau_single_incidence_rates"),
                            # Creating a row for selections side by side
                            fluidRow(
                              column(4,
                                     # Effect measure selection
                                     selectInput("effectMeasure_single_incidence_rates", "Effect measure:",
                                                 choices = c("IR", "IRLN", "IRS", "IRFT"))
                              ),
                              column(4,
                                     # Bias test selection
                                     selectInput("biastest_single_incidence_rates", "Bias test:",
                                                 choices = c("Begg", "Egger", "Thompson"))
                              ),
                              column(4,
                                     # Checkbox for random effects model
                                     checkboxInput("randomEffectsModel_single_incidence_rates", "Random Effects Model", value = TRUE),
                                     # Checkbox for fixed effects model
                                     checkboxInput("fixedEffectsModel_single_incidence_rates", "Fixed Effects Model", value = TRUE),
                                     # Checkbox for subgroup analysis
                                     checkboxInput("performSubgroupAnalysis_single_incidence_rates", "Subgroup Analysis", value = FALSE)
                              )
                            ),
                            br(),
                            # Button to perform the meta-analysis
                            actionButton("realiserMetaAnalyse_single_incidence_rates", "Perform meta-analysis"),
                            br(),
                            br(),
                            # Tabs to display results and plots
                            tabsetPanel(
                              tabPanel("Meta-analysis result", 
                                       verbatimTextOutput("metaResultText_single_incidence_rates"),
                                       downloadButton("downloadMetaResult_single_incidence_rates", "Download Meta-Analysis Results", style = "margin-bottom: 20px;")),
                              tabPanel("Forest plot", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadForestPlot_single_incidence_rates", "Download Forest Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;", # Center-align the content
                                         imageOutput("forestPlotImage_single_incidence_rates")
                                       )
                              ),
                              tabPanel("Funnel plot",
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadFunnelPlot_single_incidence_rates", "Download Funnel Plot")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("funnelPlotImage_single_incidence_rates")
                                       )),
                              tabPanel("Publication bias test", 
                                       verbatimTextOutput("pubbiastext_single_incidence_rates"),
                                       downloadButton("downloadBiasTest_single_incidence_rates", "Download Bias Test Results", style = "margin-bottom: 20px;")),
                              tabPanel("Trim and Fill", 
                                       div(
                                         style = "margin-top: 20px; display: inline-block;", # Adding margin and centering the button
                                         downloadButton("downloadtrimandfillforest_single_incidence_rates", "Download Forest Plot Trim and Fill")
                                       ),
                                       div(
                                         style = "width: 100%; height: auto; text-align: center;",
                                         imageOutput("foresttrimandfillImage_single_incidence_rates")
                                       ))
                            )
                          )
                        )
                      )
             )
             
  ),
  # Ajouter un pied de page
  div(style = "text-align: center; margin-top: 20px;",
      p("App v1.0 built by Boughanmi Mohamed-Elmehdi - mehdi.boughanmi@gmail.com")
  )
)




##########PARTIE SERVEUR##########
##################################
##################################
##################################

server <- function(input, output, session) {
  ########## PARTIE META ANALYSE VALEURS CONTINUES ##########
  ###########################################################
  ###########################################################
  ###########################################################
  ###########################################################
  ########## PARTIE META ANALYSE CONTINUE ##########
  ##################################################
  # Définir les noms de colonnes
  colonnes <- c("Study", "Subgroup", "n.e", "mean.e", "sd.e", "n.c", "mean.c", "sd.c", "Delete")
  donnees_initiales <- data.frame(matrix(NA, ncol = length(colonnes), nrow = 0))
  colnames(donnees_initiales) <- colonnes
  
  # Créer une table réactive
  donnees_reactives <- reactiveVal(donnees_initiales)
  
  # Réagir au téléchargement du fichier CSV
  observeEvent(input$fichierCSV, {
    req(input$fichierCSV)
    donnees_csv <- read.csv(input$fichierCSV$datapath, stringsAsFactors = FALSE)
    
    # Vérifier si les colonnes du fichier CSV correspondent aux colonnes attendues
    if (!all(colnames(donnees_csv) %in% colonnes[-length(colonnes)])) {
      showNotification("Les colonnes du fichier CSV ne correspondent pas aux colonnes attendues.", type = "error")
      return(NULL)
    }
    
    # Ajouter la colonne 'Delete' avec un bouton de suppression
    donnees_csv$Delete <- '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRow\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    
    # Ajouter les nouvelles données aux données réactives existantes
    donnees_actuelles <- donnees_reactives()
    donnees_mises_a_jour <- rbind(donnees_actuelles, donnees_csv)
    donnees_reactives(donnees_mises_a_jour)
  })
  
  # Réagir au bouton "Ajouter étude"
  observeEvent(input$ajouterEtude, {
    nouvelle_etude <- data.frame(
      Study = input$StudyInput,
      `n.e` = input$nsczInput,
      mean.e = input$meanSczInput,
      sd.e = input$sdSczInput,
      n.c = input$nctrlInput,
      mean.c = input$meanCtrlInput,
      sd.c = input$sdCtrlInput,
      Subgroup = input$SubgroupInput,
      Delete = '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRow\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    )
    
    # Ajouter la nouvelle étude aux données réactives
    donnees_actuelles <- donnees_reactives()
    donnees_mises_a_jour <- rbind(donnees_actuelles, nouvelle_etude)
    donnees_reactives(donnees_mises_a_jour)
  })
  
  # Créer la table dans l'interface utilisateur
  output$tableau <- renderDT({
    datatable(
      donnees_reactives(),
      escape = FALSE,
      selection = 'none',
      editable = TRUE,
      options = list(
        dom = 't',
        pageLength = 100  # Ajuster cette valeur pour afficher plus de lignes
      ),
      callback = JS(
        "table.on('click', 'button', function() {",
        "var data = table.row($(this).parents('tr')).data();",
        "Shiny.onInputChange('deleteRow', data[0]);",
        "});"
      )
    ) %>%
      formatStyle(columns = 'Delete', target = 'row', lineHeight = '15px')
  })
  
  # Réagir au bouton "Réaliser la méta-analyse"
  observeEvent(input$realiserMetaAnalyse, {
    # Vérifier s'il y a des données avant d'exécuter l'analyse
    if (nrow(donnees_reactives()) == 0) {
      showNotification("No data available for meta-analysis. Please add data before performing the analysis.", type = "error")
      return(NULL)
    }
    
    comb.fixed <- input$fixedEffectsModel
    comb.random <- input$randomEffectsModel
    
    if (input$performSubgroupAnalysis) {
      # Utiliser les données du tableau pour l'analyse des sous-groupes
      res.flesiss <- metacont(
        n.e = donnees_reactives()[["n.e"]],
        mean.e = donnees_reactives()[["mean.e"]],
        sd.e = donnees_reactives()[["sd.e"]],
        n.c = donnees_reactives()[["n.c"]],
        mean.c = donnees_reactives()[["mean.c"]],
        sd.c = donnees_reactives()[["sd.c"]],
        studlab = paste(donnees_reactives()[["Study"]], donnees_reactives()[["Subgroup"]], sep = " - "),
        data = donnees_reactives(),
        sm = input$effectMeasure,
        method.smd = "Hedges",
        subgroup = donnees_reactives()[["Subgroup"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    } else {
      # Utiliser les données du tableau pour la méta-analyse
      res.flesiss <- metacont(
        n.e = donnees_reactives()[["n.e"]],
        mean.e = donnees_reactives()[["mean.e"]],
        sd.e = donnees_reactives()[["sd.e"]],
        n.c = donnees_reactives()[["n.c"]],
        mean.c = donnees_reactives()[["mean.c"]],
        sd.c = donnees_reactives()[["sd.c"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random,
        studlab = donnees_reactives()[["Study"]],
        data = donnees_reactives(),
        sm = input$effectMeasure,
        method.smd = "Hedges"
      )
    }
    
    # Sauvegarder l'image du Forest plot dans une variable
    forest_plot_path <- tempfile(fileext = ".png")
    output$forestPlotImage <- renderImage({
      png(file = forest_plot_path, res = 300, width = 12, height = 8, units = "in")
      forest(res.flesiss)
      dev.off()
      list(src = forest_plot_path, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot")
    }, deleteFile = TRUE)
    

    # Sauvegarder l'image du Funnel plot dans une variable
    funnel_plot_path <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$funnelPlotImage <- renderImage({
      png(file = funnel_plot_path, width = 700, height = 720)
      funnel(res.flesiss)
      dev.off()
      list(src = funnel_plot_path, contentType = 'image/png', width = "100%", height = "auto", alt = "Funnel Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder le texte resultat méta analyse
    output$metaResultText <- renderPrint({
      res.flesiss
    })
    
    # meta biais, Egger test
    pub_bias <- metabias(res.flesiss, method.bias = input$biastest, k.min = 3, plotit = T)
    
    # Sauvegarder le texte resultat publication bias
    output$pubbiastext <- renderPrint({
      pub_bias
    })
    
    # Télécharger les résultats méta analyse lorsque l'on clique sur Download
    output$downloadMetaResult <- downloadHandler(
      filename = function() {
        "meta_analysis_result.txt"
      },
      content = function(file) {
        writeLines(capture.output(res.flesiss), file)
      }
    )
    
    # Télécharger le forest plot lorsque l'on clique sur Download
    output$downloadForestPlot <- downloadHandler(
      filename = function() {
        "forestplot.png"
      },
      content = function(file) {
        forest_plot_path <- tempfile(fileext = ".png")
        png(file = forest_plot_path, res = 300, width = 12, height = 8, units = "in")
        forest(res.flesiss)
        dev.off()
        file.copy(forest_plot_path, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger le funnel plot lorsque l'on clique sur Download
    output$downloadFunnelPlot <- downloadHandler(
      filename = function() {
        "funnelplot.png"
      },
      content = function(file) {
        funnel_plot_path <- tempfile(fileext = ".png")
        png(file = funnel_plot_path, width = 500, height = 500)
        funnel(res.flesiss)
        dev.off()
        file.copy(funnel_plot_path, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger les résultats du test biais de publication lorsque l'on clique sur Download
    output$downloadBiasTest <- downloadHandler(
      filename = function() {
        "bias_test_results.txt"
      },
      content = function(file) {
        writeLines(capture.output(pub_bias), file)
      }
    )
    
    # Effectuer un trim & fill après la méta-analyse continue
    tf1 <- trimfill(res.flesiss)
    summ_trimfill <- summary(tf1)
    
    # Sauvegarder l'image du Forest plot Trim and Fill dans une variable
    forest_trimfill_plot_path <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$foresttrimandfillImage <- renderImage({
      png(file = forest_trimfill_plot_path, res = 300, width = 12, height = 8, units = "in")
      forest(tf1)
      dev.off()
      list(src = forest_trimfill_plot_path, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot Trim and Fill")
    }, deleteFile = TRUE)
    
    # Télécharger le forest plot Trim and Fill lorsque l'on clique sur Download
    output$downloadtrimandfillforest <- downloadHandler(
      filename = function() {
        "forestplot_trimfill.png"
      },
      content = function(file) {
        forest_trimfill_plot_path <- tempfile(fileext = ".png")
        png(file = forest_trimfill_plot_path, res = 300, width = 12, height = 8, units = "in")
        forest(tf1)
        dev.off()
        file.copy(forest_trimfill_plot_path, file)
      },
      contentType = "image/png"
    )
  })
  
  ########## PARTIE META ANALYSE CATEGORIQUE ##########
  #####################################################
  #####################################################
  #####################################################
  #####################################################
  colonnes_cate <- c("Study", "Subgroup", "event.e", "n.e", "event.c", "n.c", "Delete")
  donnees_initiales_cate <- data.frame(matrix(NA, ncol = length(colonnes_cate), nrow = 0))
  colnames(donnees_initiales_cate) <- colonnes_cate
  
  donnees_reactives_cate <- reactiveVal(donnees_initiales_cate)
  
  # Réagir au téléchargement du fichier CSV catégorique
  observeEvent(input$fichierCSV_cate, {
    req(input$fichierCSV_cate)
    donnees_csv_cate <- read.csv(input$fichierCSV_cate$datapath, stringsAsFactors = FALSE)
    
    # Vérifier si les colonnes du fichier CSV correspondent aux colonnes attendues
    if (!all(colnames(donnees_csv_cate) %in% colonnes_cate[-length(colonnes_cate)])) {
      showNotification("Les colonnes du fichier CSV ne correspondent pas aux colonnes attendues.", type = "error")
      return(NULL)
    }
    
    # Ajouter la colonne 'Delete' avec un bouton de suppression
    donnees_csv_cate$Delete <- '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowCate\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    
    # Ajouter les nouvelles données aux données réactives existantes
    donnees_actuelles_cate <- donnees_reactives_cate()
    donnees_mises_a_jour_cate <- rbind(donnees_actuelles_cate, donnees_csv_cate)
    donnees_reactives_cate(donnees_mises_a_jour_cate)
  })
  
  # Réagir au bouton "Ajouter étude" catégorique
  observeEvent(input$ajouterEtude_cate, {
    nouvelle_etude_cate <- data.frame(
      Study = input$studyInput,
      Subgroup = input$subgroup_cat,
      event.e = input$eventeInput,
      n.e = input$neInput,
      event.c = input$eventcInput,
      n.c = input$ncInput,
      Delete = '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowCate\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    )
    
    # Ajouter la nouvelle étude aux données réactives
    donnees_actuelles_cate <- donnees_reactives_cate()
    donnees_mises_a_jour_cate <- rbind(donnees_actuelles_cate, nouvelle_etude_cate)
    donnees_reactives_cate(donnees_mises_a_jour_cate)
  })
  
  # Créer la table catégorique dans l'interface utilisateur
  output$tableau_cate <- renderDT({
    datatable(
      donnees_reactives_cate(),
      escape = FALSE,
      selection = 'none',
      editable = TRUE,
      options = list(
        dom = 't',
        pageLength = 100  # Ajuster cette valeur pour afficher plus de lignes
      ),
      callback = JS(
        "table.on('click', 'button', function() {",
        "var data = table.row($(this).parents('tr')).data();",
        "Shiny.onInputChange('deleteRowCate', data[0]);",
        "});"
      )
    ) %>%
      formatStyle(columns = 'Delete', target = 'row', lineHeight = '15px')
  })
  
  # Réagir au bouton "Réaliser la méta-analyse" catégorique
  observeEvent(input$realiserMetaAnalyse_cate, {
    # Vérifier s'il y a des données avant d'exécuter l'analyse
    if (nrow(donnees_reactives_cate()) == 0) {
      showNotification("No data available for meta-analysis. Please add data before performing the analysis.", type = "error")
      return(NULL)
    }
    
    comb.fixed <- input$fixedEffectsModel
    comb.random <- input$randomEffectsModel
    
    if (input$performSubgroupAnalysis) {
      # Utiliser les données du tableau pour l'analyse des sous-groupes
      res.flesiss_cate <- metabin(
        event.e = donnees_reactives_cate()[["event.e"]],
        n.e = donnees_reactives_cate()[["n.e"]],
        event.c = donnees_reactives_cate()[["event.c"]],
        n.c = donnees_reactives_cate()[["n.c"]],
        studlab = paste(donnees_reactives_cate()[["Study"]], donnees_reactives_cate()[["Subgroup"]], sep = " - "),
        data = donnees_reactives_cate(),
        sm = input$effectMeasure_cate,
        method = "Inverse",
        subgroup = donnees_reactives_cate()[["Subgroup"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    } else {
      # Utiliser les données du tableau pour la méta-analyse
      res.flesiss_cate <- metabin(
        event.e = donnees_reactives_cate()[["event.e"]],
        n.e = donnees_reactives_cate()[["n.e"]],
        event.c = donnees_reactives_cate()[["event.c"]],
        n.c = donnees_reactives_cate()[["n.c"]],
        studlab = donnees_reactives_cate()[["Study"]],
        data = donnees_reactives_cate(),
        sm = input$effectMeasure_cate,
        method = "Inverse",
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    }
    
    # meta biais, Egger test
    pub_bias_cate <- metabias(res.flesiss_cate, method.bias = input$biastest_cate, k.min = 3, plotit = T)
    
    # Sauvegarder l'image du Forest plot dans une variable
    forest_plot_path_cate <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$forestPlotImage_cate <- renderImage({
      png(file = forest_plot_path_cate, res = 300, width = 12, height = 8, units = "in")
      forest(res.flesiss_cate)
      dev.off()
      list(src = forest_plot_path_cate, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder l'image du Funnel plot dans une variable
    funnel_plot_path_cate <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$funnelPlotImage_cate <- renderImage({
      png(file = funnel_plot_path_cate, res = 300, width = 12, height = 8, units = "in")
      funnel(res.flesiss_cate)
      dev.off()
      list(src = funnel_plot_path_cate, contentType = 'image/png', width = "100%", height = "auto", alt = "Funnel Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder le texte resultat méta analyse
    output$metaResultText_cate <- renderPrint({
      res.flesiss_cate
    })
    
    # Sauvegarder le texte resultat publication bias
    output$pubbiastext_cate <- renderPrint({
      pub_bias_cate
    })
    
    # Télécharger les résultats méta analyse lorsque l'on clique sur Download
    output$downloadMetaResult_cate <- downloadHandler(
      filename = function() {
        "meta_analysis_result_cate.txt"
      },
      content = function(file) {
        writeLines(capture.output(res.flesiss_cate), file)
      }
    )
    
    # Télécharger le forest plot lorsque l'on clique sur Download
    output$downloadForestPlot_cate <- downloadHandler(
      filename = function() {
        "forestplot_cate.png"
      },
      content = function(file) {
        forest_plot_path_cate <- tempfile(fileext = ".png")
        png(file = forest_plot_path_cate, res = 300, width = 12, height = 8, units = "in")
        forest(res.flesiss_cate)
        dev.off()
        file.copy(forest_plot_path_cate, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger le funnel plot lorsque l'on clique sur Download
    output$downloadFunnelPlot_cate <- downloadHandler(
      filename = function() {
        "funnelplot_cate.png"
      },
      content = function(file) {
        funnel_plot_path_cate <- tempfile(fileext = ".png")
        png(file = funnel_plot_path_cate, res = 300, width = 12, height = 8, units = "in")
        funnel(res.flesiss_cate)
        dev.off()
        file.copy(funnel_plot_path_cate, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger les résultats du test biais de publication lorsque l'on clique sur Download
    output$downloadBiasTest_cate <- downloadHandler(
      filename = function() {
        "bias_test_results_cate.txt"
      },
      content = function(file) {
        writeLines(capture.output(pub_bias_cate), file)
      }
    )
    
    # Effectuer un trim & fill après la méta-analyse catégorique
    tf1_cate <- trimfill(res.flesiss_cate)
    summ_trimfill_cate <- summary(tf1_cate)
    
    # Sauvegarder l'image du Forest plot Trim and Fill dans une variable
    forest_trimfill_plot_path_cate <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$foresttrimandfillImage_cate <- renderImage({
      png(file = forest_trimfill_plot_path_cate, res = 300, width = 12, height = 8, units = "in")
      forest(tf1_cate)
      dev.off()
      list(src = forest_trimfill_plot_path_cate, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot Trim and Fill")
    }, deleteFile = TRUE)
    
    # Télécharger le forest plot Trim and Fill lorsque l'on clique sur Download
    output$downloadtrimandfillforest_cate <- downloadHandler(
      filename = function() {
        "forestplot_trimfill_cate.png"
      },
      content = function(file) {
        forest_trimfill_plot_path_cate <- tempfile(fileext = ".png")
        png(file = forest_trimfill_plot_path_cate, res = 300, width = 12, height = 8, units = "in")
        forest(tf1_cate)
        dev.off()
        file.copy(forest_trimfill_plot_path_cate, file)
      },
      contentType = "image/png"
    )
  })
  ########## PARTIE META ANALYSE DES INCIDENCE RATES ##########
  #############################################################
  #############################################################
  #############################################################
  #############################################################
  colonnes_incidence <- c("Study", "Subgroup", "event.e", "time.e", "event.c", "time.c", "Delete")
  donnees_initiales_incidence <- data.frame(matrix(NA, ncol = length(colonnes_incidence), nrow = 0))
  colnames(donnees_initiales_incidence) <- colonnes_incidence
  
  donnees_reactives_incidence <- reactiveVal(donnees_initiales_incidence)
  
  # Réagir au téléchargement du fichier CSV des incidence rates
  observeEvent(input$fichierCSV_incidence, {
    req(input$fichierCSV_incidence)
    donnees_csv_incidence <- read.csv(input$fichierCSV_incidence$datapath, stringsAsFactors = FALSE)
    
    # Vérifier si les colonnes du fichier CSV correspondent aux colonnes attendues
    if (!all(colnames(donnees_csv_incidence) %in% colonnes_incidence[-length(colonnes_incidence)])) {
      showNotification("Les colonnes du fichier CSV ne correspondent pas aux colonnes attendues.", type = "error")
      return(NULL)
    }
    
    # Ajouter la colonne 'Delete' avec un bouton de suppression
    donnees_csv_incidence$Delete <- '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowIncidence\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    
    # Ajouter les nouvelles données aux données réactives existantes
    donnees_actuelles_incidence <- donnees_reactives_incidence()
    donnees_mises_a_jour_incidence <- rbind(donnees_actuelles_incidence, donnees_csv_incidence)
    donnees_reactives_incidence(donnees_mises_a_jour_incidence)
  })
  
  # Réagir au bouton "Ajouter étude" pour les incidence rates
  observeEvent(input$ajouterEtude_incidence, {
    nouvelle_etude_incidence <- data.frame(
      Study = input$studyInput_incidence,
      Subgroup = NA,
      event.e = input$eventeINCInput,
      time.e = input$timeeINCInput,
      event.c = input$eventcINCInput,
      time.c = input$timecINCInput,
      Delete = '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowIncidence\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    )
    
    # Ajouter la nouvelle étude aux données réactives
    donnees_actuelles_incidence <- donnees_reactives_incidence()
    donnees_mises_a_jour_incidence <- rbind(donnees_actuelles_incidence, nouvelle_etude_incidence)
    donnees_reactives_incidence(donnees_mises_a_jour_incidence)
  })
  
  # Créer la table des incidence rates dans l'interface utilisateur
  output$tableau_incidence <- renderDT({
    datatable(
      donnees_reactives_incidence(),
      escape = FALSE,
      selection = 'none',
      editable = TRUE,
      options = list(
        dom = 't',
        pageLength = 100  # Ajuster cette valeur pour afficher plus de lignes
      ),
      callback = JS(
        "table.on('click', 'button', function() {",
        "var data = table.row($(this).parents('tr')).data();",
        "Shiny.onInputChange('deleteRowIncidence', data[0]);",
        "});"
      )
    ) %>%
      formatStyle(columns = 'Delete', target = 'row', lineHeight = '15px')
  })
  
  # Réagir au bouton "Réaliser la méta-analyse" pour les incidence rates
  observeEvent(input$realiserMetaAnalyse_incidence, {
    # Vérifier s'il y a des données avant d'exécuter l'analyse
    if (nrow(donnees_reactives_incidence()) == 0) {
      showNotification("No data available for meta-analysis. Please add data before performing the analysis.", type = "error")
      return(NULL)
    }
    
    comb.fixed <- input$fixedEffectsModel_incidence
    comb.random <- input$randomEffectsModel_incidence
    
    if (input$performSubgroupAnalysis_incidence) {
      # Utiliser les données du tableau pour l'analyse des sous-groupes
      res.flesiss_incidence <- metainc(
        event.e = donnees_reactives_incidence()[["event.e"]],
        time.e = donnees_reactives_incidence()[["time.e"]],
        event.c = donnees_reactives_incidence()[["event.c"]],
        time.c = donnees_reactives_incidence()[["time.c"]],
        studlab = paste(donnees_reactives_incidence()[["Study"]], donnees_reactives_incidence()[["Subgroup"]], sep = " - "),
        data = donnees_reactives_incidence(),
        sm = input$effectMeasure_incidence,
        method = "Inverse",
        subgroup = donnees_reactives_incidence()[["Subgroup"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    } else {
      # Utiliser les données du tableau pour la méta-analyse
      res.flesiss_incidence <- metainc(
        event.e = donnees_reactives_incidence()[["event.e"]],
        time.e = donnees_reactives_incidence()[["time.e"]],
        event.c = donnees_reactives_incidence()[["event.c"]],
        time.c = donnees_reactives_incidence()[["time.c"]],
        studlab = donnees_reactives_incidence()[["Study"]],
        data = donnees_reactives_incidence(),
        sm = input$effectMeasure_incidence,
        method = "Inverse",
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    }
    
    # meta biais, Egger test
    pub_bias_incidence <- metabias(res.flesiss_incidence, method.bias = input$biastest_incidence, k.min = 3, plotit = T)
    
    # Sauvegarder l'image du Forest plot dans une variable
    forest_plot_path_incidence <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$forestPlotImage_incidence <- renderImage({
      png(file = forest_plot_path_incidence, res = 300, width = 12, height = 8, units = "in")
      forest(res.flesiss_incidence)
      dev.off()
      list(src = forest_plot_path_incidence, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder l'image du Funnel plot dans une variable
    funnel_plot_path_incidence <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$funnelPlotImage_incidence <- renderImage({
      png(file = funnel_plot_path_incidence, res = 300, width = 12, height = 8, units = "in")
      funnel(res.flesiss_incidence)
      dev.off()
      list(src = funnel_plot_path_incidence, contentType = 'image/png', width = "100%", height = "auto", alt = "Funnel Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder le texte resultat méta analyse
    output$metaResultText_incidence <- renderPrint({
      res.flesiss_incidence
    })
    
    # Sauvegarder le texte resultat publication bias
    output$pubbiastext_incidence <- renderPrint({
      pub_bias_incidence
    })
    
    # Télécharger les résultats méta analyse lorsque l'on clique sur Download
    output$downloadMetaResult_incidence <- downloadHandler(
      filename = function() {
        "meta_analysis_result_incidence.txt"
      },
      content = function(file) {
        writeLines(capture.output(res.flesiss_incidence), file)
      }
    )
    
    # Télécharger le forest plot lorsque l'on clique sur Download
    output$downloadForestPlot_incidence <- downloadHandler(
      filename = function() {
        "forestplot_incidence.png"
      },
      content = function(file) {
        forest_plot_path_incidence <- tempfile(fileext = ".png")
        png(file = forest_plot_path_incidence, res = 300, width = 12, height = 8, units = "in")
        forest(res.flesiss_incidence)
        dev.off()
        file.copy(forest_plot_path_incidence, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger le funnel plot lorsque l'on clique sur Download
    output$downloadFunnelPlot_incidence <- downloadHandler(
      filename = function() {
        "funnelplot_incidence.png"
      },
      content = function(file) {
        funnel_plot_path_incidence <- tempfile(fileext = ".png")
        png(file = funnel_plot_path_incidence, res = 300, width = 12, height = 8, units = "in")
        funnel(res.flesiss_incidence)
        dev.off()
        file.copy(funnel_plot_path_incidence, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger les résultats du test biais de publication lorsque l'on clique sur Download
    output$downloadBiasTest_incidence <- downloadHandler(
      filename = function() {
        "bias_test_results_incidence.txt"
      },
      content = function(file) {
        writeLines(capture.output(pub_bias_incidence), file)
      }
    )
    
    # Effectuer un trim & fill après la méta-analyse des incidence rates
    tf1_incidence <- trimfill(res.flesiss_incidence)
    summ_trimfill_incidence <- summary(tf1_incidence)
    
    # Sauvegarder l'image du Forest plot Trim and Fill dans une variable
    forest_trimfill_plot_path_incidence <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$foresttrimandfillImage_incidence <- renderImage({
      png(file = forest_trimfill_plot_path_incidence, res = 300, width = 12, height = 8, units = "in")
      forest(tf1_incidence)
      dev.off()
      list(src = forest_trimfill_plot_path_incidence, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot Trim and Fill")
    }, deleteFile = TRUE)
    
    # Télécharger le forest plot Trim and Fill lorsque l'on clique sur Download
    output$downloadtrimandfillforest_incidence <- downloadHandler(
      filename = function() {
        "forestplot_trimfill_incidence.png"
      },
      content = function(file) {
        forest_trimfill_plot_path_incidence <- tempfile(fileext = ".png")
        png(file = forest_trimfill_plot_path_incidence, res = 300, width = 12, height = 8, units = "in")
        forest(tf1_incidence)
        dev.off()
        file.copy(forest_trimfill_plot_path_incidence, file)
      },
      contentType = "image/png"
    )
  })
  
  # Supprimer la ligne sélectionnée pour les incidence rates
  observeEvent(input$deleteRowIncidence, {
    donnees_actuelles_incidence <- donnees_reactives_incidence()
    ligne_a_supprimer_incidence <- as.numeric(input$deleteRowIncidence) + 1
    donnees_mises_a_jour_incidence <- donnees_actuelles_incidence[-ligne_a_supprimer_incidence, ]
    donnees_reactives_incidence(donnees_mises_a_jour_incidence)
  })
  
  # Toggle input section visibility pour les incidence rates
  observeEvent(input$toggleInputs_incidence, {
    shinyjs::toggle(id = "inputSection_incidence")
  })
  ########## PART META ANALYSIS OF CORRELATIONS ##########
  ########################################################
  ########################################################
  ########################################################
  ########################################################
  
  columns_correlation <- c("Study", "Subgroup", "correlation", "n", "Delete")
  initial_data_correlation <- data.frame(matrix(NA, ncol = length(columns_correlation), nrow = 0))
  colnames(initial_data_correlation) <- columns_correlation
  
  reactive_data_correlation <- reactiveVal(initial_data_correlation)
  
  # React to CSV file upload for correlations
  observeEvent(input$fichierCSV_correlation, {
    req(input$fichierCSV_correlation)
    csv_data_correlation <- read.csv(input$fichierCSV_correlation$datapath, stringsAsFactors = FALSE)
    
    # Check if the CSV columns match the expected columns
    if (!all(colnames(csv_data_correlation) %in% columns_correlation[-length(columns_correlation)])) {
      showNotification("The CSV file columns do not match the expected columns.", type = "error")
      return(NULL)
    }
    
    # Add the 'Delete' column with a delete button
    csv_data_correlation$Delete <- '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowCorrelation\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    
    # Append new data to the existing reactive data
    current_data_correlation <- reactive_data_correlation()
    updated_data_correlation <- rbind(current_data_correlation, csv_data_correlation)
    reactive_data_correlation(updated_data_correlation)
  })
  
  # React to "Add Study" button for correlations
  observeEvent(input$ajouterEtude_correlation, {
    new_study_correlation <- data.frame(
      Study = input$studyInput_correlation,
      Subgroup = input$subgroup_correlation,
      correlation = input$correlation,
      n = input$n_correlation,
      Delete = '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowCorrelation\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    )
    
    # Append new study to the existing reactive data
    current_data_correlation <- reactive_data_correlation()
    updated_data_correlation <- rbind(current_data_correlation, new_study_correlation)
    reactive_data_correlation(updated_data_correlation)
  })
  
  # Render the data table for correlations in the UI
  output$tableau_correlation <- renderDT({
    datatable(
      reactive_data_correlation(),
      escape = FALSE,
      selection = 'none',
      editable = TRUE,
      options = list(
        dom = 't',
        pageLength = 100  # Adjust this value to display more rows
      ),
      callback = JS(
        "table.on('click', 'button', function() {",
        "var data = table.row($(this).parents('tr')).data();",
        "Shiny.onInputChange('deleteRowCorrelation', data[0]);",
        "});"
      )
    ) %>%
      formatStyle(columns = 'Delete', target = 'row', lineHeight = '15px')
  })
  
  # React to "Perform meta-analysis" button for correlations
  observeEvent(input$realiserMetaAnalyse_correlation, {
    # Check if there is data before running the analysis
    if (nrow(reactive_data_correlation()) == 0) {
      showNotification("No data available for meta-analysis. Please add data before performing the analysis.", type = "error")
      return(NULL)
    }
    
    comb.fixed <- input$fixedEffectsModel_correlation
    comb.random <- input$randomEffectsModel_correlation
    
    if (input$performSubgroupAnalysis_correlation) {
      # Use data from the table for subgroup analysis
      res_flesiss_correlation <- metacor(
        cor = reactive_data_correlation()[["correlation"]],
        n = reactive_data_correlation()[["n"]],
        studlab = paste(reactive_data_correlation()[["Study"]], reactive_data_correlation()[["Subgroup"]], sep = " - "),
        data = reactive_data_correlation(),
        sm = input$effectMeasure_correlation,
        subgroup = reactive_data_correlation()[["Subgroup"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    } else {
      # Use data from the table for meta-analysis
      res_flesiss_correlation <- metacor(
        cor = reactive_data_correlation()[["correlation"]],
        n = reactive_data_correlation()[["n"]],
        studlab = reactive_data_correlation()[["Study"]],
        data = reactive_data_correlation(),
        sm = input$effectMeasure_correlation,
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    }
    
    # Perform publication bias test, Egger test
    pub_bias_correlation <- metabias(res_flesiss_correlation, method.bias = input$biastest_correlation, k.min = 3, plotit = TRUE)
    
    # Save the Forest plot image in a variable
    forest_plot_path_correlation <- tempfile(fileext = ".png")  # Create a temporary file
    output$forestPlotImage_correlation <- renderImage({
      png(file = forest_plot_path_correlation, res = 300, width = 12, height = 8, units = "in")
      forest(res_flesiss_correlation)
      dev.off()
      list(src = forest_plot_path_correlation, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot")
    }, deleteFile = TRUE)
    
    # Save the Funnel plot image in a variable
    funnel_plot_path_correlation <- tempfile(fileext = ".png")  # Create a temporary file
    output$funnelPlotImage_correlation <- renderImage({
      png(file = funnel_plot_path_correlation, res = 300, width = 12, height = 8, units = "in")
      funnel(res_flesiss_correlation)
      dev.off()
      list(src = funnel_plot_path_correlation, contentType = 'image/png', width = "100%", height = "auto", alt = "Funnel Plot")
    }, deleteFile = TRUE)
    
    # Save the meta-analysis result text
    output$metaResultText_correlation <- renderPrint({
      res_flesiss_correlation
    })
    
    # Save the publication bias test result text
    output$pubbiastext_correlation <- renderPrint({
      pub_bias_correlation
    })
    
    # Download meta-analysis results when clicking the Download button
    output$downloadMetaResult_correlation <- downloadHandler(
      filename = function() {
        "meta_analysis_result_correlation.txt"
      },
      content = function(file) {
        writeLines(capture.output(res_flesiss_correlation), file)
      }
    )
    
    # Download the Forest plot when clicking the Download button
    output$downloadForestPlot_correlation <- downloadHandler(
      filename = function() {
        "forestplot_correlation.png"
      },
      content = function(file) {
        forest_plot_path_correlation <- tempfile(fileext = ".png")
        png(file = forest_plot_path_correlation, res = 300, width = 12, height = 8, units = "in")
        forest(res_flesiss_correlation)
        dev.off()
        file.copy(forest_plot_path_correlation, file)
      },
      contentType = "image/png"
    )
    
    # Download the Funnel plot when clicking the Download button
    output$downloadFunnelPlot_correlation <- downloadHandler(
      filename = function() {
        "funnelplot_correlation.png"
      },
      content = function(file) {
        funnel_plot_path_correlation <- tempfile(fileext = ".png")
        png(file = funnel_plot_path_correlation, res = 300, width = 12, height = 8, units = "in")
        funnel(res_flesiss_correlation)
        dev.off()
        file.copy(funnel_plot_path_correlation, file)
      },
      contentType = "image/png"
    )
    
    # Download publication bias test results when clicking the Download button
    output$downloadBiasTest_correlation <- downloadHandler(
      filename = function() {
        "bias_test_results_correlation.txt"
      },
      content = function(file) {
        writeLines(capture.output(pub_bias_correlation), file)
      }
    )
    
    # Perform trim & fill after the meta-analysis of correlations
    tf1_correlation <- trimfill(res_flesiss_correlation)
    summary_trimfill_correlation <- summary(tf1_correlation)
    
    # Save the Forest plot Trim and Fill image in a variable
    forest_trimfill_plot_path_correlation <- tempfile(fileext = ".png")  # Create a temporary file
    output$foresttrimandfillImage_correlation <- renderImage({
      png(file = forest_trimfill_plot_path_correlation, res = 300, width = 12, height = 8, units = "in")
      forest(tf1_correlation)
      dev.off()
      list(src = forest_trimfill_plot_path_correlation, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot Trim and Fill")
    }, deleteFile = TRUE)
    
    # Download the Forest plot Trim and Fill when clicking the Download button
    output$downloadtrimandfillforest_correlation <- downloadHandler(
      filename = function() {
        "forestplot_trimfill_correlation.png"
      },
      content = function(file) {
        forest_trimfill_plot_path_correlation <- tempfile(fileext = ".png")
        png(file = forest_trimfill_plot_path_correlation, res = 300, width = 12, height = 8, units = "in")
        forest(tf1_correlation)
        dev.off()
        file.copy(forest_trimfill_plot_path_correlation, file)
      },
      contentType = "image/png"
    )
  })
  
  # Delete the selected row for correlations
  observeEvent(input$deleteRowCorrelation, {
    current_data_correlation <- reactive_data_correlation()
    row_to_delete_correlation <- as.numeric(input$deleteRowCorrelation) + 1
    updated_data_correlation <- current_data_correlation[-row_to_delete_correlation, ]
    reactive_data_correlation(updated_data_correlation)
  })
  
  # Toggle input section visibility for correlations
  observeEvent(input$toggleInputs_correlation, {
    shinyjs::toggle(id = "inputSection_correlation")
  })
  
  ########## PARTIE META ANALYSE SINGLE MEAN ##########
  #############################################################
  #############################################################
  #############################################################
  #############################################################
  # Columns expected in the CSV file
  columns_single_means <- c("Study", "Subgroup", "n", "mean", "sd", "Delete")
  initial_data_single_means <- data.frame(matrix(NA, ncol = length(columns_single_means), nrow = 0))
  colnames(initial_data_single_means) <- columns_single_means
  
  reactive_data_single_means <- reactiveVal(initial_data_single_means)
  
  # React to CSV file upload
  observeEvent(input$fichierCSV_single_means, {
    req(input$fichierCSV_single_means)
    csv_data_single_means <- read.csv(input$fichierCSV_single_means$datapath, stringsAsFactors = FALSE)
    
    # Check if the CSV columns match the expected columns
    if (!all(colnames(csv_data_single_means) %in% columns_single_means[-length(columns_single_means)])) {
      showNotification("The CSV file columns do not match the expected columns.", type = "error")
      return(NULL)
    }
    
    # Add the 'Delete' column with a delete button
    csv_data_single_means$Delete <- '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowSingleMeans\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    
    # Append new data to the existing reactive data
    current_data_single_means <- reactive_data_single_means()
    updated_data_single_means <- rbind(current_data_single_means, csv_data_single_means)
    reactive_data_single_means(updated_data_single_means)
  })
  
  # React to "Add Study" button
  observeEvent(input$ajouterEtude_single_means, {
    new_study_single_means <- data.frame(
      Study = input$studyInput_single_means,
      Subgroup = input$subgroup_single_means,
      n = input$nInput_single_means,
      mean = input$meanInput_single_means,
      sd = input$sdInput_single_means,
      Delete = '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowSingleMeans\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    )
    
    # Append new study to the existing reactive data
    current_data_single_means <- reactive_data_single_means()
    updated_data_single_means <- rbind(current_data_single_means, new_study_single_means)
    reactive_data_single_means(updated_data_single_means)
  })
  
  # Render the data table in the UI
  output$tableau_single_means <- renderDT({
    datatable(
      reactive_data_single_means(),
      escape = FALSE,
      selection = 'none',
      editable = TRUE,
      options = list(
        dom = 't',
        pageLength = 100  # Adjust this value to display more rows
      ),
      callback = JS(
        "table.on('click', 'button', function() {",
        "var data = table.row($(this).parents('tr')).data();",
        "Shiny.onInputChange('deleteRowSingleMeans', data[0]);",
        "});"
      )
    ) %>%
      formatStyle(columns = 'Delete', target = 'row', lineHeight = '15px')
  })
  
  # Perform meta-analysis
  observeEvent(input$realiserMetaAnalyse_single_means, {
    # Check if there is data before running the analysis
    if (nrow(reactive_data_single_means()) == 0) {
      showNotification("No data available for meta-analysis. Please add data before performing the analysis.", type = "error")
      return(NULL)
    }
    
    comb.fixed <- input$fixedEffectsModel_single_means
    comb.random <- input$randomEffectsModel_single_means
    
    if (input$performSubgroupAnalysis_single_means) {
      res_flesiss_single_means <- metamean(
        n = reactive_data_single_means()[["n"]],
        mean = reactive_data_single_means()[["mean"]],
        sd = reactive_data_single_means()[["sd"]],
        studlab = paste(reactive_data_single_means()[["Study"]], reactive_data_single_means()[["Subgroup"]], sep = " - "),
        data = reactive_data_single_means(),
        sm = input$effectMeasure_single_means,
        subgroup = reactive_data_single_means()[["Subgroup"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    } else {
      res_flesiss_single_means <- metamean(
        n = reactive_data_single_means()[["n"]],
        mean = reactive_data_single_means()[["mean"]],
        sd = reactive_data_single_means()[["sd"]],
        studlab = reactive_data_single_means()[["Study"]],
        data = reactive_data_single_means(),
        sm = input$effectMeasure_single_means,
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    }
    
    # Perform publication bias test
    pub_bias_single_means <- metabias(res_flesiss_single_means, method.bias = input$biastest_single_means, k.min = 3, plotit = TRUE)
    
    # Forest plot
    forest_plot_path_single_means <- tempfile(fileext = ".png")
    output$forestPlotImage_single_means <- renderImage({
      png(file = forest_plot_path_single_means, res = 300, width = 12, height = 8, units = "in")
      forest(res_flesiss_single_means)
      dev.off()
      list(src = forest_plot_path_single_means, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot")
    }, deleteFile = TRUE)
    
    # Funnel plot
    funnel_plot_path_single_means <- tempfile(fileext = ".png")
    output$funnelPlotImage_single_means <- renderImage({
      png(file = funnel_plot_path_single_means, res = 300, width = 12, height = 8, units = "in")
      funnel(res_flesiss_single_means)
      dev.off()
      list(src = funnel_plot_path_single_means, contentType = 'image/png', width = "100%", height = "auto", alt = "Funnel Plot")
    }, deleteFile = TRUE)
    
    # Meta-analysis result text
    output$metaResultText_single_means <- renderPrint({
      res_flesiss_single_means
    })
    
    # Publication bias test result text
    output$pubbiastext_single_means <- renderPrint({
      pub_bias_single_means
    })
    
    # Download meta-analysis results
    output$downloadMetaResult_single_means <- downloadHandler(
      filename = function() {
        "meta_analysis_result_single_means.txt"
      },
      content = function(file) {
        writeLines(capture.output(res_flesiss_single_means), file)
      }
    )
    
    # Download Forest plot
    output$downloadForestPlot_single_means <- downloadHandler(
      filename = function() {
        "forestplot_single_means.png"
      },
      content = function(file) {
        forest_plot_path_single_means <- tempfile(fileext = ".png")
        png(file = forest_plot_path_single_means, res = 300, width = 12, height = 8, units = "in")
        forest(res_flesiss_single_means)
        dev.off()
        file.copy(forest_plot_path_single_means, file)
      },
      contentType = "image/png"
    )
    
    # Download Funnel plot
    output$downloadFunnelPlot_single_means <- downloadHandler(
      filename = function() {
        "funnelplot_single_means.png"
      },
      content = function(file) {
        funnel_plot_path_single_means <- tempfile(fileext = ".png")
        png(file = funnel_plot_path_single_means, res = 300, width = 12, height = 8, units = "in")
        funnel(res_flesiss_single_means)
        dev.off()
        file.copy(funnel_plot_path_single_means, file)
      },
      contentType = "image/png"
    )
    
    # Download publication bias test results
    output$downloadBiasTest_single_means <- downloadHandler(
      filename = function() {
        "bias_test_results_single_means.txt"
      },
      content = function(file) {
        writeLines(capture.output(pub_bias_single_means), file)
      }
    )
    
    # Trim and Fill analysis
    tf1_single_means <- trimfill(res_flesiss_single_means)
    summary_trimfill_single_means <- summary(tf1_single_means)
    
    # Forest plot Trim and Fill
    forest_trimfill_plot_path_single_means <- tempfile(fileext = ".png")
    output$foresttrimandfillImage_single_means <- renderImage({
      png(file = forest_trimfill_plot_path_single_means, res = 300, width = 12, height = 8, units = "in")
      forest(tf1_single_means)
      dev.off()
      list(src = forest_trimfill_plot_path_single_means, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot Trim and Fill")
    }, deleteFile = TRUE)
    
    # Download Forest plot Trim and Fill
    output$downloadtrimfill_single_means <- downloadHandler(
      filename = function() {
        "trimfill_single_means.png"
      },
      content = function(file) {
        forest_trimfill_plot_path_single_means <- tempfile(fileext = ".png")
        png(file = forest_trimfill_plot_path_single_means, res = 300, width = 12, height = 8, units = "in")
        forest(tf1_single_means)
        dev.off()
        file.copy(forest_trimfill_plot_path_single_means, file)
      },
      contentType = "image/png"
    )
    
    # Summary of Trim and Fill analysis
    output$trimfilltext_single_means <- renderPrint({
      summary_trimfill_single_means
    })
    
    # Download Trim and Fill analysis results
    output$downloadtrimfillresults_single_means <- downloadHandler(
      filename = function() {
        "trimfillresults_single_means.txt"
      },
      content = function(file) {
        writeLines(capture.output(summary_trimfill_single_means), file)
      }
    )
  })
  
  # Toggle the manual entry section
  observeEvent(input$toggleInputs_single_means, {
    toggle("inputSection_single_means")
  })
  
  # Handle row deletion
  observeEvent(input$deleteRowSingleMeans, {
    delete_idx <- input$deleteRowSingleMeans + 1  # Adjust for R's 1-based indexing
    current_data_single_means <- reactive_data_single_means()
    current_data_single_means <- current_data_single_means[-delete_idx, ]
    reactive_data_single_means(current_data_single_means)
  })
  ########## PARTIE META ANALYSE DES SINGLE PROPORTIONS ##########
  ##########################################################
  ##########################################################
  ##########################################################
  ##########################################################
  colonnes_single_proportions <- c("Study", "Subgroup", "event", "n", "Delete")
  donnees_initiales_single_proportions <- data.frame(matrix(NA, ncol = length(colonnes_single_proportions), nrow = 0))
  colnames(donnees_initiales_single_proportions) <- colonnes_single_proportions
  
  donnees_reactives_single_proportions <- reactiveVal(donnees_initiales_single_proportions)
  
  # Réagir au téléchargement du fichier CSV des single proportions
  observeEvent(input$fichierCSV_single_proportions, {
    req(input$fichierCSV_single_proportions)
    donnees_csv_single_proportions <- read.csv(input$fichierCSV_single_proportions$datapath, stringsAsFactors = FALSE)
    
    # Vérifier si les colonnes du fichier CSV correspondent aux colonnes attendues
    if (!all(colnames(donnees_csv_single_proportions) %in% colonnes_single_proportions[-length(colonnes_single_proportions)])) {
      showNotification("Les colonnes du fichier CSV ne correspondent pas aux colonnes attendues.", type = "error")
      return(NULL)
    }
    
    # Ajouter la colonne 'Delete' avec un bouton de suppression
    donnees_csv_single_proportions$Delete <- '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowSingleProportions\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    
    # Ajouter les nouvelles données aux données réactives existantes
    donnees_actuelles_single_proportions <- donnees_reactives_single_proportions()
    donnees_mises_a_jour_single_proportions <- rbind(donnees_actuelles_single_proportions, donnees_csv_single_proportions)
    donnees_reactives_single_proportions(donnees_mises_a_jour_single_proportions)
  })
  
  # Réagir au bouton "Ajouter étude" pour les single proportions
  observeEvent(input$ajouterEtude_single_proportions, {
    nouvelle_etude_single_proportions <- data.frame(
      Study = input$studyInput_single_proportions,
      Subgroup = input$subgroup_single_proportions,
      event = input$eventInput_single_proportions,
      n = input$nInput_single_proportions,
      Delete = '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowSingleProportions\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    )
    
    # Ajouter la nouvelle étude aux données réactives
    donnees_actuelles_single_proportions <- donnees_reactives_single_proportions()
    donnees_mises_a_jour_single_proportions <- rbind(donnees_actuelles_single_proportions, nouvelle_etude_single_proportions)
    donnees_reactives_single_proportions(donnees_mises_a_jour_single_proportions)
  })
  
  # Créer la table des single proportions dans l'interface utilisateur
  output$tableau_single_proportions <- renderDT({
    datatable(
      donnees_reactives_single_proportions(),
      escape = FALSE,
      selection = 'none',
      editable = TRUE,
      options = list(
        dom = 't',
        pageLength = 100  # Ajuster cette valeur pour afficher plus de lignes
      ),
      callback = JS(
        "table.on('click', 'button', function() {",
        "var data = table.row($(this).parents('tr')).data();",
        "Shiny.onInputChange('deleteRowSingleProportions', data[0]);",
        "});"
      )
    ) %>%
      formatStyle(columns = 'Delete', target = 'row', lineHeight = '15px')
  })
  
  # Réagir au bouton "Réaliser la méta-analyse" pour les single proportions
  observeEvent(input$realiserMetaAnalyse_single_proportions, {
    # Vérifier s'il y a des données avant d'exécuter l'analyse
    if (nrow(donnees_reactives_single_proportions()) == 0) {
      showNotification("No data available for meta-analysis. Please add data before performing the analysis.", type = "error")
      return(NULL)
    }
    
    comb.fixed <- input$fixedEffectsModel_single_proportions
    comb.random <- input$randomEffectsModel_single_proportions
    
    if (input$performSubgroupAnalysis_single_proportions) {
      # Utiliser les données du tableau pour l'analyse des sous-groupes
      res.flesiss_single_proportions <- metaprop(
        event = donnees_reactives_single_proportions()[["event"]],
        n = donnees_reactives_single_proportions()[["n"]],
        studlab = paste(donnees_reactives_single_proportions()[["Study"]], donnees_reactives_single_proportions()[["Subgroup"]], sep = " - "),
        data = donnees_reactives_single_proportions(),
        sm = input$effectMeasure_single_proportions,
        subgroup = donnees_reactives_single_proportions()[["Subgroup"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    } else {
      # Utiliser les données du tableau pour la méta-analyse
      res.flesiss_single_proportions <- metaprop(
        event = donnees_reactives_single_proportions()[["event"]],
        n = donnees_reactives_single_proportions()[["n"]],
        studlab = donnees_reactives_single_proportions()[["Study"]],
        data = donnees_reactives_single_proportions(),
        sm = input$effectMeasure_single_proportions,
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    }
    
    # meta biais, Egger test
    pub_bias_single_proportions <- metabias(res.flesiss_single_proportions, method.bias = input$biastest_single_proportions, k.min = 3, plotit = TRUE)
    
    # Sauvegarder l'image du Forest plot dans une variable
    forest_plot_path_single_proportions <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$forestPlotImage_single_proportions <- renderImage({
      png(file = forest_plot_path_single_proportions, res = 300, width = 12, height = 8, units = "in")
      forest(res.flesiss_single_proportions)
      dev.off()
      list(src = forest_plot_path_single_proportions, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder l'image du Funnel plot dans une variable
    funnel_plot_path_single_proportions <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$funnelPlotImage_single_proportions <- renderImage({
      png(file = funnel_plot_path_single_proportions, res = 300, width = 12, height = 8, units = "in")
      funnel(res.flesiss_single_proportions)
      dev.off()
      list(src = funnel_plot_path_single_proportions, contentType = 'image/png', width = "100%", height = "auto", alt = "Funnel Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder le texte resultat méta analyse
    output$metaResultText_single_proportions <- renderPrint({
      res.flesiss_single_proportions
    })
    
    # Sauvegarder le texte resultat publication bias
    output$pubbiastext_single_proportions <- renderPrint({
      pub_bias_single_proportions
    })
    
    # Télécharger les résultats méta analyse lorsque l'on clique sur Download
    output$downloadMetaResult_single_proportions <- downloadHandler(
      filename = function() {
        "meta_analysis_result_single_proportions.txt"
      },
      content = function(file) {
        writeLines(capture.output(res.flesiss_single_proportions), file)
      }
    )
    
    # Télécharger le forest plot lorsque l'on clique sur Download
    output$downloadForestPlot_single_proportions <- downloadHandler(
      filename = function() {
        "forestplot_single_proportions.png"
      },
      content = function(file) {
        forest_plot_path_single_proportions <- tempfile(fileext = ".png")
        png(file = forest_plot_path_single_proportions, res = 300, width = 12, height = 8, units = "in")
        forest(res.flesiss_single_proportions)
        dev.off()
        file.copy(forest_plot_path_single_proportions, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger le funnel plot lorsque l'on clique sur Download
    output$downloadFunnelPlot_single_proportions <- downloadHandler(
      filename = function() {
        "funnelplot_single_proportions.png"
      },
      content = function(file) {
        funnel_plot_path_single_proportions <- tempfile(fileext = ".png")
        png(file = funnel_plot_path_single_proportions, res = 300, width = 12, height = 8, units = "in")
        funnel(res.flesiss_single_proportions)
        dev.off()
        file.copy(funnel_plot_path_single_proportions, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger les résultats du test biais de publication lorsque l'on clique sur Download
    output$downloadBiasTest_single_proportions <- downloadHandler(
      filename = function() {
        "bias_test_results_single_proportions.txt"
      },
      content = function(file) {
        writeLines(capture.output(pub_bias_single_proportions), file)
      }
    )
    
    # Effectuer un trim & fill après la méta-analyse des single proportions
    tf1_single_proportions <- trimfill(res.flesiss_single_proportions)
    summ_trimfill_single_proportions <- summary(tf1_single_proportions)
    
    # Sauvegarder l'image du Forest plot Trim and Fill dans une variable
    forest_trimfill_plot_path_single_proportions <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$foresttrimandfillImage_single_proportions <- renderImage({
      png(file = forest_trimfill_plot_path_single_proportions, res = 300, width = 12, height = 8, units = "in")
      forest(tf1_single_proportions)
      dev.off()
      list(src = forest_trimfill_plot_path_single_proportions, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot Trim and Fill")
    }, deleteFile = TRUE)
    
    # Télécharger le forest plot Trim and Fill lorsque l'on clique sur Download
    output$downloadtrimandfillforest_single_proportions <- downloadHandler(
      filename = function() {
        "forestplot_trimfill_single_proportions.png"
      },
      content = function(file) {
        forest_trimfill_plot_path_single_proportions <- tempfile(fileext = ".png")
        png(file = forest_trimfill_plot_path_single_proportions, res = 300, width = 12, height = 8, units = "in")
        forest(tf1_single_proportions)
        dev.off()
        file.copy(forest_trimfill_plot_path_single_proportions, file)
      },
      contentType = "image/png"
    )
  })
  
  # Supprimer la ligne sélectionnée pour les single proportions
  observeEvent(input$deleteRowSingleProportions, {
    donnees_actuelles_single_proportions <- donnees_reactives_single_proportions()
    ligne_a_supprimer_single_proportions <- as.numeric(input$deleteRowSingleProportions) + 1
    donnees_mises_a_jour_single_proportions <- donnees_actuelles_single_proportions[-ligne_a_supprimer_single_proportions, ]
    donnees_reactives_single_proportions(donnees_mises_a_jour_single_proportions)
  })
  
  # Toggle input section visibility pour les single proportions
  observeEvent(input$toggleInputs_single_proportions, {
    shinyjs::toggle(id = "inputSection_single_proportions")
  })
  
  ########## PARTIE META ANALYSE DES SINGLE INCIDENCE RATES ##########
  ##########################################################
  ##########################################################
  ##########################################################
  ##########################################################
  colonnes_single_incidence_rates <- c("Study", "Subgroup", "events", "time", "Delete")
  donnees_initiales_single_incidence_rates <- data.frame(matrix(NA, ncol = length(colonnes_single_incidence_rates), nrow = 0))
  colnames(donnees_initiales_single_incidence_rates) <- colonnes_single_incidence_rates
  
  donnees_reactives_single_incidence_rates <- reactiveVal(donnees_initiales_single_incidence_rates)
  
  # Réagir au téléchargement du fichier CSV des single incidence rates
  observeEvent(input$fichierCSV_single_incidence_rates, {
    req(input$fichierCSV_single_incidence_rates)
    donnees_csv_single_incidence_rates <- read.csv(input$fichierCSV_single_incidence_rates$datapath, stringsAsFactors = FALSE)
    
    # Vérifier si les colonnes du fichier CSV correspondent aux colonnes attendues
    if (!all(colnames(donnees_csv_single_incidence_rates) %in% colonnes_single_incidence_rates[-length(colonnes_single_incidence_rates)])) {
      showNotification("Les colonnes du fichier CSV ne correspondent pas aux colonnes attendues.", type = "error")
      return(NULL)
    }
    
    # Ajouter la colonne 'Delete' avec un bouton de suppression
    donnees_csv_single_incidence_rates$Delete <- '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowSingleIncidenceRates\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    
    # Ajouter les nouvelles données aux données réactives existantes
    donnees_actuelles_single_incidence_rates <- donnees_reactives_single_incidence_rates()
    donnees_mises_a_jour_single_incidence_rates <- rbind(donnees_actuelles_single_incidence_rates, donnees_csv_single_incidence_rates)
    donnees_reactives_single_incidence_rates(donnees_mises_a_jour_single_incidence_rates)
  })
  
  # Réagir au bouton "Ajouter étude" pour les single incidence rates
  observeEvent(input$ajouterEtude_single_incidence_rates, {
    nouvelle_etude_single_incidence_rates <- data.frame(
      Study = input$studyInput_single_incidence_rates,
      Subgroup = input$subgroup_single_incidence_rates,
      events = input$eventsInput_single_incidence_rates,
      time = input$timeInput_single_incidence_rates,
      Delete = '<button class="btn btn-danger btn-sm" onclick="Shiny.onInputChange(\'deleteRowSingleIncidenceRates\', this.parentElement.parentElement.rowIndex - 1);">X</button>'
    )
    
    # Ajouter la nouvelle étude aux données réactives
    donnees_actuelles_single_incidence_rates <- donnees_reactives_single_incidence_rates()
    donnees_mises_a_jour_single_incidence_rates <- rbind(donnees_actuelles_single_incidence_rates, nouvelle_etude_single_incidence_rates)
    donnees_reactives_single_incidence_rates(donnees_mises_a_jour_single_incidence_rates)
  })
  
  # Créer la table des single incidence rates dans l'interface utilisateur
  output$tableau_single_incidence_rates <- renderDT({
    datatable(
      donnees_reactives_single_incidence_rates(),
      escape = FALSE,
      selection = 'none',
      editable = TRUE,
      options = list(
        dom = 't',
        pageLength = 100  # Ajuster cette valeur pour afficher plus de lignes
      ),
      callback = JS(
        "table.on('click', 'button', function() {",
        "var data = table.row($(this).parents('tr')).data();",
        "Shiny.onInputChange('deleteRowSingleIncidenceRates', data[0]);",
        "});"
      )
    ) %>%
      formatStyle(columns = 'Delete', target = 'row', lineHeight = '15px')
  })
  
  # Réagir au bouton "Réaliser la méta-analyse" pour les single incidence rates
  observeEvent(input$realiserMetaAnalyse_single_incidence_rates, {
    # Vérifier s'il y a des données avant d'exécuter l'analyse
    if (nrow(donnees_reactives_single_incidence_rates()) == 0) {
      showNotification("No data available for meta-analysis. Please add data before performing the analysis.", type = "error")
      return(NULL)
    }
    
    comb.fixed <- input$fixedEffectsModel_single_incidence_rates
    comb.random <- input$randomEffectsModel_single_incidence_rates
    
    if (input$performSubgroupAnalysis_single_incidence_rates) {
      # Utiliser les données du tableau pour l'analyse des sous-groupes
      res.flesiss_single_incidence_rates <- metarate(
        event = donnees_reactives_single_incidence_rates()[["events"]],
        time = donnees_reactives_single_incidence_rates()[["time"]],
        studlab = paste(donnees_reactives_single_incidence_rates()[["Study"]], donnees_reactives_single_incidence_rates()[["Subgroup"]], sep = " - "),
        data = donnees_reactives_single_incidence_rates(),
        sm = input$effectMeasure_single_incidence_rates,
        subgroup = donnees_reactives_single_incidence_rates()[["Subgroup"]],
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    } else {
      # Utiliser les données du tableau pour la méta-analyse
      res.flesiss_single_incidence_rates <- metarate(
        event = donnees_reactives_single_incidence_rates()[["events"]],
        time = donnees_reactives_single_incidence_rates()[["time"]],
        studlab = donnees_reactives_single_incidence_rates()[["Study"]],
        data = donnees_reactives_single_incidence_rates(),
        sm = input$effectMeasure_single_incidence_rates,
        comb.fixed = comb.fixed,
        comb.random = comb.random
      )
    }
    
    # meta biais, Egger test
    pub_bias_single_incidence_rates <- metabias(res.flesiss_single_incidence_rates, method.bias = input$biastest_single_incidence_rates, k.min = 3, plotit = TRUE)
    
    # Sauvegarder l'image du Forest plot dans une variable
    forest_plot_path_single_incidence_rates <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$forestPlotImage_single_incidence_rates <- renderImage({
      png(file = forest_plot_path_single_incidence_rates, res = 300, width = 12, height = 8, units = "in")
      forest(res.flesiss_single_incidence_rates)
      dev.off()
      list(src = forest_plot_path_single_incidence_rates, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder l'image du Funnel plot dans une variable
    funnel_plot_path_single_incidence_rates <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$funnelPlotImage_single_incidence_rates <- renderImage({
      png(file = funnel_plot_path_single_incidence_rates, res = 300, width = 12, height = 8, units = "in")
      funnel(res.flesiss_single_incidence_rates)
      dev.off()
      list(src = funnel_plot_path_single_incidence_rates, contentType = 'image/png', width = "100%", height = "auto", alt = "Funnel Plot")
    }, deleteFile = TRUE)
    
    # Sauvegarder le texte resultat méta analyse
    output$metaResultText_single_incidence_rates <- renderPrint({
      res.flesiss_single_incidence_rates
    })
    
    # Sauvegarder le texte resultat publication bias
    output$pubbiastext_single_incidence_rates <- renderPrint({
      pub_bias_single_incidence_rates
    })
    
    # Télécharger les résultats méta analyse lorsque l'on clique sur Download
    output$downloadMetaResult_single_incidence_rates <- downloadHandler(
      filename = function() {
        "meta_analysis_result_single_incidence_rates.txt"
      },
      content = function(file) {
        writeLines(capture.output(res.flesiss_single_incidence_rates), file)
      }
    )
    
    # Télécharger le forest plot lorsque l'on clique sur Download
    output$downloadForestPlot_single_incidence_rates <- downloadHandler(
      filename = function() {
        "forestplot_single_incidence_rates.png"
      },
      content = function(file) {
        forest_plot_path_single_incidence_rates <- tempfile(fileext = ".png")
        png(file = forest_plot_path_single_incidence_rates, res = 300, width = 12, height = 8, units = "in")
        forest(res.flesiss_single_incidence_rates)
        dev.off()
        file.copy(forest_plot_path_single_incidence_rates, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger le funnel plot lorsque l'on clique sur Download
    output$downloadFunnelPlot_single_incidence_rates <- downloadHandler(
      filename = function() {
        "funnelplot_single_incidence_rates.png"
      },
      content = function(file) {
        funnel_plot_path_single_incidence_rates <- tempfile(fileext = ".png")
        png(file = funnel_plot_path_single_incidence_rates, res = 300, width = 12, height = 8, units = "in")
        funnel(res.flesiss_single_incidence_rates)
        dev.off()
        file.copy(funnel_plot_path_single_incidence_rates, file)
      },
      contentType = "image/png"
    )
    
    # Télécharger les résultats du test biais de publication lorsque l'on clique sur Download
    output$downloadBiasTest_single_incidence_rates <- downloadHandler(
      filename = function() {
        "bias_test_results_single_incidence_rates.txt"
      },
      content = function(file) {
        writeLines(capture.output(pub_bias_single_incidence_rates), file)
      }
    )
    
    # Effectuer un trim & fill après la méta-analyse des single incidence rates
    tf1_single_incidence_rates <- trimfill(res.flesiss_single_incidence_rates)
    summ_trimfill_single_incidence_rates <- summary(tf1_single_incidence_rates)
    
    # Sauvegarder l'image du Forest plot Trim and Fill dans une variable
    forest_trimfill_plot_path_single_incidence_rates <- tempfile(fileext = ".png")  # Créer un fichier temporaire
    output$foresttrimandfillImage_single_incidence_rates <- renderImage({
      png(file = forest_trimfill_plot_path_single_incidence_rates, res = 300, width = 12, height = 8, units = "in")
      forest(tf1_single_incidence_rates)
      dev.off()
      list(src = forest_trimfill_plot_path_single_incidence_rates, contentType = 'image/png', width = "100%", height = "auto", alt = "Forest Plot Trim and Fill")
    }, deleteFile = TRUE)
    
    # Télécharger le forest plot Trim and Fill lorsque l'on clique sur Download
    output$downloadtrimandfillforest_single_incidence_rates <- downloadHandler(
      filename = function() {
        "forestplot_trimfill_single_incidence_rates.png"
      },
      content = function(file) {
        forest_trimfill_plot_path_single_incidence_rates <- tempfile(fileext = ".png")
        png(file = forest_trimfill_plot_path_single_incidence_rates, res = 300, width = 12, height = 8, units = "in")
        forest(tf1_single_incidence_rates)
        dev.off()
        file.copy(forest_trimfill_plot_path_single_incidence_rates, file)
      },
      contentType = "image/png"
    )
  })
  
  # Supprimer la ligne sélectionnée pour les single incidence rates
  observeEvent(input$deleteRowSingleIncidenceRates, {
    donnees_actuelles_single_incidence_rates <- donnees_reactives_single_incidence_rates()
    ligne_a_supprimer_single_incidence_rates <- as.numeric(input$deleteRowSingleIncidenceRates) + 1
    donnees_mises_a_jour_single_incidence_rates <- donnees_actuelles_single_incidence_rates[-ligne_a_supprimer_single_incidence_rates, ]
    donnees_reactives_single_incidence_rates(donnees_mises_a_jour_single_incidence_rates)
  })
  
  # Toggle input section visibility pour les single incidence rates
  observeEvent(input$toggleInputs_single_incidence_rates, {
    shinyjs::toggle(id = "inputSection_single_incidence_rates")
  })
  
  
  ############## SUPPRESSION DES LIGNES ##############
  ####################################################
  ####################################################
  ####################################################
  ####################################################
  # Supprimer la ligne sélectionnée continue
  observeEvent(input$deleteRow, {
    donnees_actuelles <- donnees_reactives()
    ligne_a_supprimer <- as.numeric(input$deleteRow) + 1
    donnees_mises_a_jour <- donnees_actuelles[-ligne_a_supprimer, ]
    donnees_reactives(donnees_mises_a_jour)
  })
  
  # Supprimer la ligne catégorique sélectionnée
  observeEvent(input$deleteRowCate, {
    donnees_actuelles_cate <- donnees_reactives_cate()
    ligne_a_supprimer_cate <- as.numeric(input$deleteRowCate) + 1
    donnees_mises_a_jour_cate <- donnees_actuelles_cate[-ligne_a_supprimer_cate, ]
    donnees_reactives_cate(donnees_mises_a_jour_cate)
  })
  
  # Supprimer la ligne sélectionnée pour les sous-groupes
  observeEvent(input$deleteRow_subgroup, {
    donnees_actuelles_subgroup <- donnees_reactives_subgroup()
    ligne_a_supprimer_subgroup <- as.numeric(input$deleteRow_subgroup) + 1
    donnees_mises_a_jour_subgroup <- donnees_actuelles_subgroup[-ligne_a_supprimer_subgroup, ]
    donnees_reactives_subgroup(donnees_mises_a_jour_subgroup)
  })
  
  # Toggle input section visibility
  observeEvent(input$toggleInputs, {
    shinyjs::toggle(id = "inputSection")
  })
  
  observeEvent(input$toggleInputs_cate, {
    shinyjs::toggle(id = "inputSection_cate")
  })
  
  # Toggle input section visibility pour les sous-groupes
  observeEvent(input$toggleInputs_subgroup, {
    shinyjs::toggle(id = "inputSection_subgroup")
  })
  
  ############## TÉLÉCHARGEMENT DES FICHIERS D'EXEMPLE ##############
  ###########################################################
  ###########################################################
  ###########################################################
  ###########################################################
  # Téléchargement de l'exemple pour les résultats continus
  output$downloadExampleContinuous <- downloadHandler(
    filename = function() {
      "Continuous_Outcomes_Example.csv"
    },
    content = function(file) {
      write.csv(data.frame(
        Study = c("Study1", "Study2"),
        Mean = c(1.2, 2.3),
        SD = c(0.5, 0.7),
        N = c(100, 150)
      ), file)
    }
  )
  
  # Téléchargement de l'exemple pour les résultats catégoriques
  output$downloadExampleCategorical <- downloadHandler(
    filename = function() {
      "Categorical_Outcomes_Example.csv"
    },
    content = function(file) {
      write.csv(data.frame(
        Study = c("Study1", "Study2"),
        event.e = c(10, 20),
        n.e = c(100, 150),
        event.c = c(5, 10),
        n.c = c(100, 150)
      ), file)
    }
  )
  
  # Téléchargement de l'exemple pour les taux d'incidence
  output$downloadExampleIncidence <- downloadHandler(
    filename = function() {
      "Incidence_Rates_Example.csv"
    },
    content = function(file) {
      write.csv(data.frame(
        Study = c("Study1", "Study2"),
        Subgroup = c("Group1", "Group2"),
        event.e = c(10, 20),
        time.e = c(1000, 2000),
        event.c = c(5, 10),
        time.c = c(1000, 2000)
      ), file)
    }
  )
  
  # Téléchargement de l'exemple pour les corrélations
  output$downloadExampleCorrelations <- downloadHandler(
    filename = function() {
      "Correlations_Example.csv"
    },
    content = function(file) {
      write.csv(data.frame(
        Study = c("Study1", "Study2"),
        Subgroup = c("Subgroup1", "Subgroup2"),
        correlation = c(0.5, 0.6),
        n = c(100, 150)
      ), file, row.names = FALSE)
    }
  )
  
  # Téléchargement de l'exemple pour les moyennes simples
  output$downloadExampleSingleMeans <- downloadHandler(
    filename = function() {
      "Single_Means_Example.csv"
    },
    content = function(file) {
      write.csv(data.frame(
        Study = c("Study1", "Study2"),
        n = c(100, 150),
        mean = c(1.2, 2.3),
        sd = c(0.5, 0.7)
      ), file)
    }
  )
  
  # Téléchargement de l'exemple pour les proportions simples
  output$downloadExampleSingleProportions <- downloadHandler(
    filename = function() {
      "Single_Proportions_Example.csv"
    },
    content = function(file) {
      write.csv(data.frame(
        Study = c("Study1", "Study2"),
        event = c(10, 20),
        n = c(100, 150)
      ), file)
    }
  )
  
  # Téléchargement de l'exemple pour les taux d'incidence simples
  output$downloadExampleSingleIncidence <- downloadHandler(
    filename = function() {
      "Single_Incidence_Rates_Example.csv"
    },
    content = function(file) {
      write.csv(data.frame(
        Study = c("Study1", "Study2"),
        event = c(10, 20),
        time = c(1000, 2000)
      ), file)
    }
  )
  
}

# Lancer l'application Shiny
shinyApp(ui, server)