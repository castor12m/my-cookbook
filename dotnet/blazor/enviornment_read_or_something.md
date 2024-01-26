

load

```bash
    # ubuntu 환경변수
    var env_value_buff = System.Environment.GetEnvironmentVariable("PATH");
    Console.WriteLine(" blazor env1 : [{0}]", env_value_buff);

    # appsettings.json 에 있는 변수
    env_value_buff = System.Environment.GetEnvironmentVariable("SatelliteMode");
    Console.WriteLine(" blazor env2 : [{0}]", env_value_buff);

    # Properties/launchSettings.json 의 environmentVariables 내에 있는 변수
    env_value_buff = System.Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
    Console.WriteLine(" blazor env3 : [{0}]", env_value_buff);
```

dotnet watch 결과

```bash
    dotnet watch 🔥 Hot reload of changes succeeded.
    blazor env1 : [/home/stbtest/.vscode-server/bin/af28b32d7e553898b2a91af498b1fb666fdebe0c/bin/remote-cli:/home/stbtest/.local/bin:/home/stbtest/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin]
    blazor env2 : []
    blazor env3 : [Development]
    2024-01-26 20:43:25,293 [INFO] 2024-01-26 20:43:25.292, SdsDataService init mode : [obs1a]

```