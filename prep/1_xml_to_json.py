import json
import xml.sax

ignore_tags=lambda x: (":" in x or x=="source" or x.startswith("create"))
class Handler( xml.sax.ContentHandler ):
    def __init__(self):
        super()
        self.db=[]
        self.fhs={}

    def startElement(self, tag, attrs):
        t=tag.lower()
        if t in ("node","way","relation"):
            self.type=t[0]
            self.o={}
            self.o["id"]=attrs["id"]
        if t=="node":
            self.o["lat"]=attrs["lat"]
            self.o["lon"]=attrs["lon"]
        if t=="nd":
            if "ids" not in self.o:
                self.o["ids"]=[]
            self.o["ids"].append(int(attrs["ref"]))
        if t=="member":
            if "members" not in self.o:
                self.o["members"]=[]
            self.o["members"].append((
attrs.get("ref",""),
attrs.get("role",""),
attrs.get("type",""),))
        if t=="tag":
            k=attrs["k"]
            if ignore_tags(k):
                return
            if "tags" not in self.o:
                self.o["tags"]=[]
            self.o["tags"].append((attrs["k"],attrs["v"],))

    def endElement(self, tag):
        if tag.lower() not in ("node","way","relation"):
            return
        if self.type not in self.fhs:
            self.fhs[self.type]=open("/dev/shm/db.%s.json" % (self.type,), "w")
        print(json.dumps(self.o), file=self.fhs[self.type])

def main():
    global handler
    parser = xml.sax.make_parser()
    parser.setFeature(xml.sax.handler.feature_namespaces, 0)
    handler = Handler()
    parser.setContentHandler(handler)
    parser.parse("wv.osm.xml")

main()
