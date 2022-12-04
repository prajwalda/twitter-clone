package tech.codingclub.helix.entity;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import tech.codingclub.helix.global.HttpUrlConExample;

public class WikipediaDownloader{

   private String keyword;

    public WikipediaDownloader(){

    }
    public WikipediaDownloader(String keyword) {
        this.keyword = keyword;
    }


    public WikiResult getResult() {
     //get clean keyword
     //get the url for wikipedia
     //make a GET request to wikipedia
     //parsing the useful result using jsoup
     //showing results to the user
      if(this.keyword==null || this.keyword.length()==0){
          return null;
      }
    this.keyword=this.keyword.trim().replaceAll("[ ]+","_");
    //step 1 is done
      String wikiurl=getWikipediaUrlForQuery(this.keyword);
        String response="";
        String imgurl="";
        try {
            //step 3
            String wikipediaResponseHTML= HttpUrlConExample.sendGet(wikiurl);
            //System.out.println(wikipediaResponse);
            //step 4
            Document document= Jsoup.parse(wikipediaResponseHTML,"https://en.wikipedia.org");
           Elements childElements= document.body().select(".mw-parser-output > *");
            int state=0;

            for(Element childElement : childElements) {
                if (state == 0) {
                    if (childElement.tagName().equals("table")) {
                        state = 1;
                    }
                } else if (state == 1) {
                    if (childElement.tagName().equals("p")) {
                        state = 2;
                        response = childElement.text();
                        break;
                    }
                }
                try {
                 imgurl =document.body().select(".infobox img").get(0).attr("src");
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        WikiResult wikiresult=new WikiResult(this.keyword,response,imgurl);
        //push result into database
//        Gson gson=new GsonBuilder().setPrettyPrinting().create();
//        String json=gson.toJson(wikiresult);
//        return json;
        return wikiresult;
    }

    private String getWikipediaUrlForQuery(String cleanKeyword) {
        return "https://en.wikipedia.org/wiki/"+cleanKeyword;
    }

}
