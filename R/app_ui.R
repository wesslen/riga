#' @import shiny
app_ui <- function() {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    dashboardPage(
      dashboardHeader(title = "Riga"),
      dashboardSidebar(
        sidebarMenu(
          menuItem("Overview", tabName = "overview", icon = icon("dashboard")),
          menuItem("Labeling", icon = icon("th"), tabName = "labeling",
                   badgeLabel = "new", badgeColor = "green"),
          menuItem("Modeling", icon = icon("th"), tabName = "modeling",
                   badgeLabel = "new", badgeColor = "blue"),
          menuItem("Evaluation", icon = icon("th"), tabName = "evaluation",
                   badgeLabel = "new", badgeColor = "red")
        )
      ),
      dashboardBody(
        tabItems(
          tabItem(tabName = "overview",
                  h2("Dashboard tab content"),
                  p("Please upload your file"),
                  br(),
                  fileInput("file1", "Choose CSV File",
                            multiple = FALSE,
                            accept = c("text/csv",
                                       "text/comma-separated-values,text/plain",
                                       ".csv"))
          ),
          
          tabItem(tabName = "labeling",
                  h1("Labeling"),
                  p("This is a simple demo of the R package shinyswipr. Swipe on the quote card below to store your rating. What each direction (up, down, left, right) mean is up to you. (We won't tell.)"),
                  hr(),
                  shinyswipr_UI( "quote_swiper",
                                 ## add in twitter handles
                                 h4("Swipe Me!"),
                                 hr(),
                                 h4("Quote:"),
                                 textOutput("quote"),
                                 h4("Author(s):"),
                                 textOutput("quote_author")
                  ),
                  hr(),
                  h4("Swipe History"),
                  tableOutput("resultsTable")
          ),
          tabItem(tabName = "modeling",
                  h2("Widgets tab content")
          ),
          tabItem(tabName = "evaluation",
                  h2("Widgets tab content")
          )
        )
      )
    )
  )
}

#' @import shiny
golem_add_external_resources <- function(){
  
  addResourcePath(
    'www', system.file('app/www', package = 'riga')
  )
 
  tags$head(
    golem::activate_js(),
    golem::favicon()
    # Add here all the external resources
    # If you have a custom.css in the inst/app/www
    # Or for example, you can add shinyalert::useShinyalert() here
    #tags$link(rel="stylesheet", type="text/css", href="www/custom.css")
  )
}
