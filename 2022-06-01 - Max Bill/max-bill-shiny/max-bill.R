sample_k <- function() {
  c(sample(8,1), sample(7,1), sample(6,1), sample(5,1), sample(4,1))
}

inscribe_polygon_data <- function(n = 8, k = NULL, x0 = 0, y0 = 0, angle = 0) {
  
  if (is.null(k)) k <- sample(1:n, 1)
  
  rn <- 1/sin(pi/n)
  rnm1 <- 1/sin(pi/(n-1))
  an <- 1/tan(pi/n)
  anm1 <- 1/tan(pi/(n-1))
  
  rd <- rn-rnm1 # r_difference
  ad <- an-anm1
  
  ang <- angle + (k-1)*2*pi/n
  
  out <- list(n = n - 1, x0 = x0 + ad*cos(ang), y0 = y0 + ad*sin(ang), angle = pi/2 + ang, r = rn)
  
  return(out)
  
  #ggplot() +
  #  geom_regon(aes(x0 = x0, y0 = y0, sides = n, r = rn, angle = pi/2 + angle), 
  #      color = col_n, fill = col_n) + 
  #  geom_regon(aes(x0 = x0 + ad*cos(ang), y0 = y0 + ad*sin(ang), sides = n-1, r = rnm1, angle = pi/2 + ang), color = col_nm1, fill = col_nm1)  +
  #  coord_fixed()  
  
}

max_bill_rearrange <- function(k = NULL) {
  
  if (is.null(k)) k <- sample_k()
  
  cols <- c(NA, NA, "#F7A520", "#E53822", "#3AA542", "#3945AA", "#F45D1B", "#803971")
  
  rn <- 1/sin(pi/(1:8))
  
  hept <- inscribe_polygon_data(n = 8, k = k[1])
  hex <- inscribe_polygon_data(n = 7, k = k[2], x0 = hept$x0, y0 = hept$y0, angle = hept$angle - pi/2)
  pent <- inscribe_polygon_data(n = 6, k = k[3], x0 = hex$x0, y0 = hex$y0, angle = hex$angle - pi/2)
  sq <- inscribe_polygon_data(n = 5, k = k[4], x0 = pent$x0, y0 = pent$y0, angle = pent$angle - pi/2)
  tri <- inscribe_polygon_data(n = 4, k = k[5], x0 = sq$x0, y0 = sq$y0, angle = sq$angle - pi/2)
  
  ggplot() +
    geom_regon(aes(x0 = 0, y0 = 0, sides = 8, r = rn[8], angle = 0), colour = cols[8], fill = cols[8]) +
    geom_regon(aes(x0 = hept$x0, y0 = hept$y0, sides = 7, r = rn[7], angle = hept$angle), colour = cols[7], fill = cols[7]) +
    geom_regon(aes(x0 = hex$x0, y0 = hex$y0, sides = 6, r = rn[6], angle = hex$angle), colour = cols[6], fill = cols[6]) +
    geom_regon(aes(x0 = pent$x0, y0 = pent$y0, sides = 5, r = rn[5], angle = pent$angle), colour = cols[5], fill = cols[5]) +
    geom_regon(aes(x0 = sq$x0, y0 = sq$y0, sides = 4, r = rn[4], angle = sq$angle), colour = cols[4], fill = cols[4]) +  
    geom_regon(aes(x0 = tri$x0, y0 = tri$y0, sides = 3, r = rn[3], angle = tri$angle), colour = cols[3], fill = cols[3]) + 
    coord_fixed(xlim = c(-3.5, 3.5), ylim = c(-3.5,3.5)) +
    annotate("text", label = "max bill", x = -a8, y = 3.2, hjust = 0, family = "Times", size = 4.5) +
    annotate("text", label = "ella kaye", x = -a8, y = 2.92, hjust = 0, family = "Times", size = 3.5) +
    annotate("text", label = "die grafischen reihen", x = a8, y = 3.2, hjust = 1, family = "Times", size = 4.5) +
    annotate("text", label = "rearranged", x = a8, y = 2.92, hjust = 1, family = "Times", size = 3.5) +
    annotate("text", label = "#RecreationThursday", x = 0, y = -3.1, family = "Times", size = 3.5) +
    annotate("text", label = "@DataScixDesign", x = 0, y = -3.38, family = "Times", size = 3.5) +
    theme_void() +
    theme(panel.background = element_rect(fill = '#F4F2E9', colour = '#F4F2E9'))
}
