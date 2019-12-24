#' @import shiny
app_server <- function(input, output,session) {
  # List the first level callModules here
  card_swipe <- callModule(shinyswipr, "quote_swiper")
  
  quote               <- fortune()
  output$quote        <- renderText({ quote$quote })
  output$quote_author <- renderText({ paste0("-",quote$author) })
  output$resultsTable <- renderDataTable({appVals$swipes})
  
  appVals <- reactiveValues(
    quote  = quote,
    swipes = data.frame(quote = character(), author = character(), swipe = character())
  )
  
  observeEvent( card_swipe(),{
    #Record our last swipe results.
    appVals$swipes <- rbind(
      data.frame(quote  = appVals$quote$quote,
                 author = appVals$quote$author,
                 swipe  = card_swipe()
      ),
      appVals$swipes
    )
    #send results to the output.
    output$resultsTable <- renderTable({appVals$swipes})
    
    #update the quote
    appVals$quote <- fortune()
    
    #send update to the ui.
    output$quote <- renderText({ appVals$quote$quote })
    output$quote_author <- renderText({ paste0("-",appVals$quote$author) })
  }) #close event observe.
  
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, head of that data file by default,
    # or all rows if selected, will be shown.
    
    req(input$file1)
    
    # when reading semicolon separated files,
    # having a comma separator causes `read.csv` to error
    tryCatch(
      {
        df <- read.csv(input$file1$datapath,
                       header = input$header,
                       sep = input$sep,
                       quote = input$quote)
      },
      error = function(e) {
        # return a safeError if a parsing error occurs
        stop(safeError(e))
      }
    )
  })
  
}
