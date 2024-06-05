def write_file(arry, fn)
File.open(fn,"wb") do |ofh|
arry.size.to_u64.to_io ofh, IO::ByteFormat::LittleEndian
arry.each do |i|
i[0].to_io ofh, IO::ByteFormat::LittleEndian
i[1].to_io ofh, IO::ByteFormat::LittleEndian
i[2].to_io ofh, IO::ByteFormat::LittleEndian
end # each i
end # file
end

def main
arry=nil
File.open("coords.raw","rb") do |fh|
count=UInt64.from_io fh, IO::ByteFormat::LittleEndian
arry=Array(Tuple(Float64, Float64, UInt64)).new initial_capacity: count
count.times do
arry << ({
Float64.from_io(fh, IO::ByteFormat::LittleEndian),
Float64.from_io(fh, IO::ByteFormat::LittleEndian),
UInt64.from_io(fh, IO::ByteFormat::LittleEndian)
})
end # each
end # file
arry=arry.not_nil!
arry.sort_by! {|i| ({i[0],i[1]}) }
write_file arry, "lat_lon.coords"
arry.size.times do |idx|
arry[idx]=({arry[idx][1],arry[idx][0],arry[idx][2]})
end
arry.sort_by! {|i| ({i[0],i[1]}) }
write_file arry, "lon_lat.coords"
end # def

main
