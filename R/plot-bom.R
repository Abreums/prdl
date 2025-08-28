# Libraries
library(ggraph)
library(igraph)
library(tidyverse)
library(RColorBrewer)

plot_bom <- function(bom) {
  hierarchy <- 
    bom |> 
    select(material_number, bom_component)
  
  vertices <- tibble(
    name = unique(c(as.character(hierarchy$material_number), 
                    as.character(hierarchy$bom_component))))
  
  # Create a graph object with the igraph library
  mygraph <- graph_from_data_frame( hierarchy, vertices=vertices )
  
  # This is a network object, you visualize it as a network like shown in the network section!
  # With ggraph:
  # ggraph(mygraph, layout = 'dendrogram', circular = FALSE) + 
  #   geom_edge_link(aes(colour = factor(from))) +
  #   geom_node_text(aes(label = name), angle = 20) + # 'name' is often the default node attribute for labels
  #   theme_void()
  # 
  ggraph(mygraph, layout = "partition") +
    scale_fill_gradient(low = "white", high = "lightblue") +
    geom_node_tile(aes(fill = depth)) +
    geom_node_text(aes(label = name), angle = 20) + # 'name' is often the default node attribute for labels
    theme_void()  
}

sankey_bom <- function(bom) {
  bom = tera_bom
  hierarchy <- 
    bom |> 
    select(from=material_number, to=bom_component)
  
  nodes <- tibble(
    name = unique(c(as.character(hierarchy$from), 
                    as.character(hierarchy$to))))
  
  # Create a graph object with the igraph library
  grph_object <- graph_from_data_frame( nodes, vertices=vertices )
  
  colors ='d3.scaleOrdinal() .range(["#FDE725FF","#B4DE2CFF","#6DCD59FF",
        "#35B779FF","#1F9E89FF","#26828EFF",
        "#31688EFF","#3E4A89FF","#482878FF","#440154FF"])'
  
  nodes <- grph_object %>%
    activate(nodes) %>%
    data.frame()
  
  edges <- grph_object %>%
    activate(edges) %>%
    mutate(source = from - 1,
           target = to - 1) %>%
    data.frame() %>%
    select(source, target, distance)
  
  network_p <- sankeyNetwork(Links = edges, Nodes = nodes,
                             Source = 'source', Target = 'target', 
                             Value = 'distance', NodeID = 'name',
                             fontSize = 14, nodeWidth = 20, 
                             sinksRight = FALSE, 
                             colourScale = colors
  )
  print(network_p)

}

