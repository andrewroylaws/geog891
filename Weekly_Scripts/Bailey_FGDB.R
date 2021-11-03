require(rgdal)

# The input file geodatabase
fgdb <- "./data/gSSURGO_NE.gdb"

# List all feature classes in a file geodatabase
subset(ogrDrivers(), grepl("GDB", name))
fc_list <- ogrListLayers(fgdb)
print(fc_list)

# Read the feature class
fc <- readOGR(dsn=fgdb,layer="MUPOLYGON")

# Determine the FC extent, projection, and attribute information
summary(fc)

# View the feature class
tm_shape(fc) + tm_polygons()
