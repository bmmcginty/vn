require "json"
File.open("coords.raw","wb") do |ofh|
0_u64.to_io ofh, IO::ByteFormat::LittleEndian
idx=0_u64
File.open("json/db.n.json") do |fh|
fh.each_line do |line|
idx+=1
j=JSON.parse line
j["lat"].as_s.to_f64.to_io ofh, IO::ByteFormat::LittleEndian
j["lon"].as_s.to_f64.to_io ofh, IO::ByteFormat::LittleEndian
j["id"].as_s.to_u64.to_io ofh, IO::ByteFormat::LittleEndian
end # each
end # fh
ofh.seek 0
idx.to_io ofh, IO::ByteFormat::LittleEndian
end # ofh
