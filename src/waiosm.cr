require "geo"

def find_closest(l, val)
l.bsearch_index {|i| i[0]>=val }
end

def read_file(fn)
arry=nil
File.open(fn,"rb") do |fh|
count=UInt64.from_io fh, IO::ByteFormat::LittleEndian
arry=Array(Tuple(Float64, Float64, UInt64)).new initial_capacity: count
count.times do
arry << ({
Float64.from_io(fh, IO::ByteFormat::LittleEndian),
Float64.from_io(fh, IO::ByteFormat::LittleEndian),
UInt64.from_io(fh, IO::ByteFormat::LittleEndian)
})
end
end
arry.not_nil!
end

def main
lat_lon_id=read_file("lat_lon.coords")
lon_lat_id=read_file("lon_lat.coords")
pt="38.31027 -81.60319".split(" ")
lat,lon=pt[0].to_f64, pt[1].to_f64
a=Time.measure do
lat_idx=find_closest lat_lon_id, lat
puts "lat_idx #{lat_idx} searched #{lat} found #{lat_lon_id[lat_idx.not_nil!]}"
lon_idx=find_closest lon_lat_id, lon
puts "lon_idx #{lon_idx} searched #{lon} found #{lon_lat_id[lon_idx.not_nil!]}"
end #measure
puts "took #{a}"
end # def

main
