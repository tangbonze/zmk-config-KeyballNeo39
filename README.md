![](https://web-api.textin.com/ocr_image/external/a8fbeec7ad58d1c1.jpg)

## Skinner39

Skinner39は、Yawkeeさん制作のkeyballにインスピレーションを受けて開発した、OLED搭載の無線分割キーボードです。ブレードランナー2049のファンとして、映画に登場する近未来的な廃墟の街並みと空飛ぶクルマをイメージソースとしてSkinner39を設計しました。組み立てガイドは、こちらとなります：https://aeolian-melon-437.notion.site/Skinner39-1a14484f44ee80c3916ad98ebab79145

##  商品詳細

·完全無線（MS88SF2）

· ZMK studio & ZMK firmware

·OLEDディスプレイ搭載

·ロープロ·ハイプロファイル対応＊1

·34mm·25mmトラックボール搭載可能＆専用ケース

·トラボ位置調整可能な3Dプリントケース

·背面リセットボタン、Bluetooth ON／OFFスイッチ搭載

·超薄型リチウムバッテリー＊2

·マグネット式テンティング機能

##  内容物

·完成品左右セット（キー数：39キー）

·MS88SF2モジュール

·はんだ済み基板2枚＊3

·本体ケース

·トッププレート

·25mm／34mmのトラックボールケース（セラミックス支持球付き）

·25mm/34mmトラックボール

·省電力トラックボールセンサー

·電源スイッチ

·ダイオード

·ネジ2種

·スペーサー

·ゴム足

## 注意事項

＊1 Choc v1、Choc v2、MX軸のすべてに対応していますが、Choc V1を使用する場合は専用キートップを購入するか、3Dプリントでキートップを作成する必要があります。

＊2リチウムイオンバッテリーの取り扱いには十分な安全注意が必要です。取り扱いの不備による事故·損害等について、当方は一切の責任を負いかねますのでご了承ください。バッテリーの安全に関する詳細は、以下のサイトをご確認ください。

https://www.baj.r.jp/battery/safety/safety16.html

＊3 Choc V1、V2、MX軸対応のソケットは実装済みです。ロープロとハイプロファイルの両方の軸を好みに合わせ使用したい場合は、それぞれに対応したケースとプレートを別途ご購入してください。

## 設定ガイド

 Skinner39の設定方法

·左手側がメインユニットです。

·USB接続は左手側で行ってください。

·なお、右手のみをPCに接続した場合、キーボードは動作しません。

·PCのBluetooth一覧に表示される［Skinner39］を選択して接続します。

·接続が完了すると、両手のOLEDに「Wi-Fi」マークと接続設備「番号」が表示されます。

#  Bluetooth接続ができない場合

1．［bt＿clr］キーと［2］キーを同時に押して、再度無線接続を試みてください。

2．接続できない時、リセットボタン（ケース背面の丸いボタン）を1回押してリセットします。

3．その後、再度［bt＿clr］キーと［2］キーを押して、無線接続を行ってください。

<!-- 0 symbol_layer |SYM --- 1 Skp 6kp 6kp 6kp 6kp 6kp 5kp Skp 2 ! @ # &#36; % Y U 1 O P 3 6bt 6bt 6bt Strons 6kp Skp 6kp 4 BT_CLR BT_SEL O BT_SEL 1 BT_SEL 2 H J K 5kp Skp L ; (BT_CLR)Clear profile 5 Strons Gtrans Gtrans Gtrons Strans Skp Skp 6kp Skp 6kp 6 N M , / + Strans Gtrons Strons 6kp 1 Gtrans Strans Strans 6kp  -->
![](https://web-api.textin.com/ocr_image/external/9f48b8ead660bd21.jpg)

##  設定を間違えてしまった場合

1． ZMK GitHub Actionsで再度フォークし、ファームウェアをダウンロードします。

2．両手のキーボードをUSB接続します。

3． リセットボタンを押すと、PCに「keyball」というデバイスが表示されます。

4．Keyballにリセットファイルを貼り付けます。

5．リセット完了となります。

---

# dya 分支（DYA Studio 対応）

`dya` 分支把 Skinner39 接到 **DYA Studio**（cormoran 的 ZMK Studio 增强版）上，
轨迹球驱动和 keyball `dya-nv` 分支用的是同一套：cormoran 的 PMW3610 驱动
（devicetree 兼容名 `cormoran,pmw3610`）+ DYA 的 custom Studio RPC 模块。
`main` 分支保持原样，本分支为新增的 `dya` 分支。

## 与 main 分支的差别

| 项目 | main | dya（本分支） |
| --- | --- | --- |
| ZMK | `zmkfirmware/zmk@main` | `cormoran/zmk@main+dya` |
| Zephyr | 随 ZMK 决定 | `cormoran/zephyr@v4.1.0+zmk-fixes+nrf-half-duplex-uart` |
| 轨迹球驱动 | badjeff `pixart,pmw3610` | cormoran `cormoran,pmw3610`（与 keyball dya-nv 相同） |
| 跨半输入 | badjeff split relay 模块 | 不需要：轨迹球所在的右半就是中央 |
| Studio | 官方 ZMK Studio（键位编辑） | 官方功能 + DYA Studio（轨迹球、连接、设置、宏、组合键、诊断） |
| 板级定义 | `boards/arm/...`（HWMv1） | `boards/yangxing/...` + `board.yml`（Zephyr HWMv2） |

### 已启用的 DYA Studio 功能

* **Keymap**：官方 ZMK Studio 键位/层编辑，布局预览里会画出轨迹球位置；
  **Macro** 子页可以创建/改名/删除运行时宏；**Combo** 子页可以编辑运行时组合键
* **Trackball**：CPI、轴方向、smart algorithm、downshift/sample 等参数在线调整；
  运行时可调的输入处理器（速度、旋转、轴吸附、自动鼠标层）
* **Connection**：BLE profile 管理、OS 自动识别、按连接/OS 切换默认层
* **Settings**：休眠/空闲超时等设置、通用 custom settings、电池历史
* **Troubleshooting**：device info、watchdog 重启原因、KSCAN 诊断

## 构建与烧录

本地（需要 `west`、Zephyr SDK、`protoc`）：

```sh
make init-standalone   # 下载依赖到 ./dependencies
make build-all         # 输出到 ./build/<artifact>/zephyr/zmk.uf2
```

也可以直接用 GitHub Actions 的 `Build ZMK firmware` 工作流。

| 文件 | 用途 |
| --- | --- |
| `skinner39_right.uf2` | 右半 = **主手（中央）**，接 USB / 连蓝牙的那一半，轨迹球也在这一半 |
| `skinner39_left.uf2` | 左半 = 副手（外设） |
| `skinner39_left_reset.uf2` / `skinner39_right_reset.uf2` | 清空已保存的设置，从固件默认值重新开始 |

刷完固件后建议先各刷一次 `*_reset.uf2`（两边都要），再刷正式固件。

## 使用 DYA Studio

1. 用 USB 连接右半（主手）
2. 打开 <https://studio.dya.cormoran.works/>
3. 「Connect via USB」连接键盘

本分支关闭了 Studio 自动锁定（`CONFIG_ZMK_STUDIO_LOCKING=n`）。键位里也保留了
`&studio_unlock`：**按住 SPACE（MOUSE 层）+ 左下角那颗键**即可在需要时解锁。

## 键位上的几处新增行为

* **自动鼠标层**：转动轨迹球 200ms 后自动激活第 4 层（MOUSE），停手 400ms 后自动
  退出；两项参数都能在 DYA Studio 里改。
* **滚轮层 / snipe 层**：第 5 层（SCROLL）轨迹球变成滚轮，第 6 层（SNIPE）变成
  1/3 速度慢速移动，参数同样可以在 Studio 里调。
* **运行时宏**：DYA Studio 的 Macro 页新建宏后会分配到槽位号（0 ~ 7），键位上用
  `&rmacro <槽位号>` 播放；当前固件在 **按住 SPACE + 左下角第二颗键** 绑了
  `&rmacro 0` 作示例（空槽位按下去没有动作）。默认 8 个宏、每个最大 256 字节，
  可在 `skinner39_right_defconfig` 里调。
* **运行时组合键**：Combo 页里按槽位编辑「哪几个键位同时按下 → 触发什么行为」。
  固件里没有预置组合键，所以添加之前键盘行为不变；默认 8 个槽位、每个最多 16 个
  键位，可在 `skinner39_right_defconfig` 里调。

## 注意事项

* 板级定义已迁移到 Zephyr **HWMv2**。ZMK `main` 从 Zephyr 4.1 开始要求这一点，
  旧写法（`boards/arm/...` + `Kconfig.board`）在当前 ZMK 上无法构建。
* 主手是**右半**（`ZMK_SPLIT_ROLE_CENTRAL` 在 `skinner39_right` 上）：USB、蓝牙、
  ZMK Studio / DYA Studio 的 RPC 全部在右半；左半只跑键盘矩阵和屏幕，保留与主手
  同步设置所需的 relay。
* 轨迹球挂在右半，刚好和主手同一半，所以是本地直连；传感器设置对外暴露的键名前缀
  是 `ball`（例如 `cpi@ball`）。
* `CONFIG_ZMK_BATTERY_HISTORY=y` 会周期性写入 flash。如果不看电池历史，可以在
  `skinner39_right_defconfig` 里关掉这两个开关以减少 flash 写入。
* 布局预览里的轨迹球位置是估算值（`skinner39.dtsi` 的 `trackball_layout`），
  如果和实物不符，改 `x` / `y` / `size` 即可。
