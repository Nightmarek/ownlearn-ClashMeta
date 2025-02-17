import { vpnExtension } from '@kit.NetworkKit';
import { common, Want } from '@kit.AbilityKit';
import { Icon } from './compoments/icons';
import { ActionCard,  ActionLabel } from './compoments/common';
import { NetworkSettingsPage, SettingsPage } from './SettingsPage';
import { ConfigEditPage, ConfigsPage } from './ConfigEditPage';
import { ProxysPage } from './ProxyPage';
import profileViewModel, { ProfileViewModel } from '../entryability/ProfileViewModel';
import { Profile } from '../entryability/ProfileRepo';
import { LogsPage } from './LogsPage';
import logger from '../pages/logs';
import { promptAction } from '@kit.ArkUI';
import { ClashVpnService } from '../entryability/ClashVpnService';
import { ProviderPage } from './ProviderPage';
import { ConfigViewer } from './ConfigViewer';

let want: Want = {
  deviceId: "",
  bundleName: "com.xiaobai.clash",
  abilityName: "ClashVpnAbility",
};

@Builder
function PageRouter(name: string, params:string) {
  if (name === "proxys") {
    ProxysPage()
  } else if (name === "settings") {
    SettingsPage()
  }
  else if (name === "network-settings") {
    NetworkSettingsPage()
  }
  else if (name === "configs") {
    ConfigsPage()
  }else if (name === "config-edit") {
    ConfigEditPage()
  }else if (name === "config-viewer") {
    ConfigViewer({configPath: params})
  } else if (name === "LogsPage") {
    LogsPage()
  } else if (name === "ProviderPage") {
    ProviderPage()
  }
}


@Entry
@Component
struct Index {

  vpnConnection = vpnExtension.createVpnConnection(getContext(this) as common.VpnExtensionContext);
  @Provide('router') routerInfos: NavPathStack = new NavPathStack()
  @State running: boolean = false;
  @State loading: boolean = false;
  @State profile: Profile | undefined = undefined
  async aboutToAppear(): Promise<void> {
    this.profile = await profileViewModel.getActive()
    // let result = await clashProxyService.start(getContext(this) as common.UIAbilityContext)
    // this.running = result
     //  clashViewModel.init(getContext(this))
     // clashViewModel.load()
    // this.routerInfos.setInterception({
    //   willShow: async (from: NavDestinationContext | "navBar", to: NavDestinationContext | "navBar",
    //     operation: NavigationOperation, animated: boolean) => {
    //   }
    // })
  }

  async startVpn(){
    logger.clear()
    logger.log("index","开启vpn后台服务")
    let profile = await profileViewModel.getActive()
    this.profile = profile
    if(!profile){
      promptAction.showToast({message:"没有选择配置文件"})
      return
    }
    await vpnExtension.startVpnExtensionAbility(want);
    this.running  = true
    this.loading = true
    profileViewModel.running = true
    setTimeout(async ()=>{
      this.loading = false;
    },1000)

  }
  async stopVpn(){
    this.running = false
    await vpnExtension.stopVpnExtensionAbility(want)
    profileViewModel.running = false
  }
  scroller: Scroller = new Scroller();

  async testVpn(){
    const clashVpnService = new ClashVpnService(await profileViewModel.getHome());
    const profile = await profileViewModel.getActive()
    if (profile != undefined){
      let configPath = await profileViewModel.getConfigPath(profile)
      clashVpnService.StartVpn(configPath, getContext(this), [])
    }else{
      logger.log("ClashVPN", `配置文件 没有加载 `);
    }
  }

  build() {
    Navigation(this.routerInfos) {
      List() {
        ListItem() {
          Column() {
            Row(){
              Icon({icon:$r(`app.media.ic_baseline_meta`)})
              Text("Clash Meta For HarmonyOS").fontSize(20).fontWeight(FontWeight.Bold)
            }.padding({ top: 20 })
            if(!this.running){
              ActionCard({title:"已停止", value: "点击启动", loading: this.loading, isRunning: this.running, icon:"ic_outline_not_interested", click: async ()=>{
                this.startVpn()
              } })
            }else{
              ActionCard({title:"运行中", value: "已转发",loading: this.loading, isRunning: this.running,  icon:"ic_outline_check_circle", click: async ()=>{
                if(!this.loading){
                  this.stopVpn()
                }
              }})
              ActionCard({title:"代理", value: "规则模式", icon:"ic_baseline_apps", click: async ()=>{
                if(!this.loading){
                  this.routerInfos.pushPath({name:"proxys"})
                }
              }})
            }
            ActionCard({title:"配置", value: !this.profile ? "未选择": this.profile.name, icon:"ic_baseline_view_list", click:()=>{
              this.routerInfos.pushPath({name:"configs"})
            }})
            if(this.running){
              ActionLabel({title:"外部资源", icon:"ic_baseline_extension", click:()=>{
                if(!this.loading){
                  this.routerInfos.pushPath({name:"ProviderPage"})
                }
              }})
              ActionLabel({title:"日志", icon:"ic_baseline_view_list", click:()=>{
                if(!this.loading){
                  this.routerInfos.pushPath({name: "LogsPage"})
                }
              }})
            }
            ActionLabel({title:"设置", icon:"ic_baseline_settings", click:()=>{
              this.routerInfos.pushPath({ name: "settings" })
            }})
            // ActionLabel({title:"关于", icon:"ic_baseline_info"})
            // Text(this.message)
            //   .fontSize(50)
            //   .fontWeight(FontWeight.Bold)
            //   .onClick(async () => {
            //     let config = new Config(this.tunIp, "");
            //     try {
            //       let tunFd = await this.vpnConnection.create(config)
            //       hilog.info(0x0000, 'testTag', 'start tun %{public}d', tunFd);
            //       testNapi.add(tunFd, 3, (fd:number)=>{
            //         hilog.info(0x0000, 'ClashMeta', 'protect tun %{public}d', fd);
            //         this.vpnConnection.protect(fd).catch((e:Error)=>{
            //           hilog.info(0x0000, 'testTag', 'protect failed %{public}s', e.message);
            //         })
            //       })
            //     } catch (e) {
            //       this.vpnConnection.destroy()
            //       hilog.info(0x0000, 'testTag', 'vpn failure %{public}s', e.message);
            //     }
            //   })
          }
        }
      }
      .height('100%')
    }.navDestination(PageRouter).mode(NavigationMode.Stack)
  }
}

