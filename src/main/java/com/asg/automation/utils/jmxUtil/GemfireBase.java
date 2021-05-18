package com.asg.automation.utils.jmxUtil;

import com.asg.automation.utils.JsonRead;
import org.apache.geode.cache.*;
import org.apache.geode.cache.client.ClientCache;
import org.apache.geode.cache.client.ClientCacheFactory;
import org.apache.geode.cache.client.ClientRegionShortcut;
import org.apache.geode.cache.query.QueryService;
import org.apache.geode.cache.query.SelectResults;
import org.apache.geode.cache.server.CacheServer;
import org.apache.geode.cache.server.ClientSubscriptionConfig;
import org.apache.geode.cache.server.ServerLoadProbe;
import org.apache.geode.distributed.DistributedMember;
import org.apache.geode.distributed.LocatorLauncher;
import org.apache.geode.distributed.ServerLauncher;
import org.apache.geode.cache.*;
import org.apache.geode.cache.Region;
import org.apache.geode.cache.RegionShortcut;
import org.apache.geode.management.cli.CommandStatement;
import org.apache.geode.management.cli.Result;
import org.apache.geode.management.cli.CommandService;
import org.apache.geode.management.cli.CommandServiceException;

import org.apache.geode.cache.RegionFactory;

import java.io.IOException;
import java.util.*;

import com.asg.automation.utils.rest.RestBuilderUtil;
import com.asg.automation.wrapper.RestAPIWrapper;
import scala.Int;

import static com.asg.automation.utils.Constant.TEST_DATA_PATH;
import static org.apache.geode.distributed.ConfigurationProperties.LOCATORS;
import static org.apache.geode.distributed.ConfigurationProperties.MCAST_PORT;



public class GemfireBase implements  AutoCloseable {

    private ClientCache cache ;

  public void createCache(String hostName)
  {

      cache = new ClientCacheFactory().addPoolLocator(hostName, 10334).create();


  }

  public Long getRegionSize(String regionName , ClientCache cache) throws Exception
  {
      QueryService qservice = cache.getQueryService();
      SelectResults result = (SelectResults) qservice
              .newQuery(String.format("select count(*) from %s", "/"+regionName)).execute();

      Iterator iter = result.iterator();

      Long regionSize = Long.valueOf(iter.next().toString());

      System.out.println("size value  :: "  +regionSize);

      return regionSize;

  }

  public List<String> getMembers(ClientCache cache)  throws Exception
  { QueryService qservice = cache.getQueryService();
      SelectResults result = (SelectResults) qservice
              .newQuery("list members").execute();

      Iterator iter = result.iterator();

      List<String> hosts =new ArrayList<String>();

      while(iter.hasNext())
      {
          hosts.add(iter.next().toString());
          System.out.println(iter.next().toString());
      }

      return hosts;

  }

    public List<String> getRegions()  throws Exception
    { QueryService qservice = cache.getQueryService();
        SelectResults result = (SelectResults) qservice
                .newQuery("list regions").execute();

        Iterator iter = result.iterator();

        List<String> regions =new ArrayList<String>();

        while(iter.hasNext())
        {
            regions.add(iter.next().toString());
            System.out.println(iter.next().toString());
        }

        return regions;

    }


  public void addRegionData(String regionName)

  {

      if(regionName.equalsIgnoreCase("employee")) {
          Region<Object, Object> emp = cache.createClientRegionFactory(ClientRegionShortcut.CACHING_PROXY).create(regionName);
          Map< String,  Long> userMap =  new HashMap< String,  Long>();
          userMap.put("Ajay" , 62200354654645777L);
          userMap.put("Rekha" , 62200354654645756L);
          userMap.put("Balan" , 62200354654645766L);
          userMap.put("Sruthi" , 62200354654645723L);
          userMap.put("Mani" , 62200354654645711L);
          userMap.put("Geetha" , 62200354654645789L);
          userMap.put("Kalai" , 62200354654645790L);
          userMap.put("Raja" , 62200354654645745L);

            emp.putAll(userMap);
      }
      else if(regionName.equalsIgnoreCase("berry")) {
          Region<Object, Object> berry = cache.createClientRegionFactory(ClientRegionShortcut.CACHING_PROXY).create(regionName);
          Map< Long,  Float> userMap =  new HashMap< Long,  Float>();
          userMap.put(62200354654645777L , 30.9F);
          userMap.put(62200354654645756L , 24.7F);
          userMap.put(62200354654645766L , 11.9F);

          Map< Boolean,  Double> userMap2 =  new HashMap< Boolean,  Double>();
          userMap2.put(true , 78.90);
          userMap2.put(false , 56.45);

          Map< String, Integer> userMap3 =  new HashMap< String,  Integer>();
          userMap3.put("rate" , 6789);
          berry.putAll(userMap);
          berry.putAll(userMap2);
          berry.putAll(userMap3);
      }
  }

    public static void main(String args[])
    {
        GemfireBase gm = new GemfireBase();

        try {

           gm.createCache("wiproidadocker.4ms4abhdsaluha2oiens35fpmg.tx.internal.cloudapp.net");
           gm.getMembers(gm.cache);


        }
        catch (Exception e)
        {
            System.out.println("exception  :: "  +e.toString());
        }
    }

    @Override
    public void close() throws Exception {
        cache.close();
    }
}
