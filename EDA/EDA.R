#Carga de librerías
library(dplyr)
library(ggplot2)

# Establecer el directorio de trabajo (ajusta la ruta según tu caso)
setwd("C:/Repositorios-Ing.Carlos-Cicconi/Universidad_Austral_MCD/Laboratorio de Implementación III")

c# Cargar los archivos .txt
sell_in <- read.table("sell-in.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
tb_productos <- read.table("tb_productos.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)
tb_stocks <- read.table("tb_stocks.txt", header = TRUE, sep = "\t", stringsAsFactors = FALSE)

# Verificar las primeras filas de cada archivo
head(sell_in)
head(tb_productos)
head(tb_stocks)

#Merge de sell_in y tb_productos por el campo product_id
sell_in_completo <- merge(sell_in, tb_productos, by = "product_id", all = TRUE)
unique(sell_in_completo$cat2)

# Asegurarse de que 'periodo' esté ordenado como factor
sell_in_completo$periodo <- factor(sell_in_completo$periodo, levels = sprintf("%02d", 1:12), ordered = TRUE)

ggplot(sell_in_completo, aes(x = periodo, y = tn, color = cat1, group = cat1)) +
  geom_line() +
  geom_point() +
  labs(title = "Gráfico de Líneas Agrupadas por Periodo y Cat1",
       x = "Periodo",
       y = "TN",
       color = "Cat1") +
  theme_minimal()


sell_in_jabonropa <- sell_in_completo %>%
  filter(cat2 == "ROPA LAVADO")

sell_in_jabonliq <- sell_in_jabonropa %>%
  filter(cat3 == "Liquido")

unique(sell_in_jabonliq$sku_size)
factor(sell_in_jabonliq$sku_size)
