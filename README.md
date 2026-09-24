# Keyball Neo 39 · dya

**简体中文** &nbsp;|&nbsp; [English](#english)

---

## 简体中文

### 关于这块键盘

**Keyball Neo 39**（原名 Skinner39）是一块 39 键的无线分体键盘：OLED（nice!view）屏幕、
可换 25mm / 34mm 轨迹球、支持低 / 高轴，外壳带磁吸倾斜结构。设计由 yangxing 完成，
灵感来自 Yawkee 的 keyball 系列；47 键的大尺寸版本叫 **Keyball Neo 47**，
见 `zmk-config-KeyballNeo47`。
组装指南：<https://aeolian-melon-437.notion.site/Skinner39-1a14484f44ee80c3916ad98ebab79145>

`dya` 分支把这块键盘接到 **DYA Studio**（cormoran 的 ZMK Studio 增强版）上，
轨迹球驱动和 keyball `dya-nv` 分支用的是同一套：cormoran 的 PMW3610 驱动
（devicetree 兼容名 `cormoran,pmw3610`）+ DYA 的 custom Studio RPC 模块。

`main` 分支保持原样，改动都在 `dya` 分支上（它也是现在的默认分支）。

键盘对外显示的名字是 **Keyball Neo 39**：蓝牙 / USB 设备名、ZMK Studio 里的键盘名和
布局名都用它（来自 `ZMK_KEYBOARD_NAME`、`display-name`、`*.zmk.yml`）。板 ID、目录、
keymap 和固件文件名也用同一个名字：板 ID 是 `keyball_neo39_left` /
`keyball_neo39_right`，keymap 是 `config/keyball_neo39.keymap`，固件是
`keyball_neo39_*.uf2`（旧名 `skinner39*` 已全部替换）。

本仓库只有两个分支：`dya`（DYA Studio 版，也是默认分支）和 `main`（原来的
badjeff 驱动配置）。这份 README 在两个分支上内容相同，下文表格说明了它们的差别。

### 与 main 分支的差别

| 项目 | main | dya |
| --- | --- | --- |
| ZMK | `zmkfirmware/zmk@main` | `cormoran/zmk@main+dya` |
| Zephyr | 随 ZMK 决定 | `cormoran/zephyr@v4.1.0+zmk-fixes+nrf-half-duplex-uart` |
| 轨迹球驱动 | badjeff `pixart,pmw3610` | cormoran `cormoran,pmw3610`（与 keyball dya-nv 相同） |
| 跨半输入 | badjeff split relay 模块 | 不需要：轨迹球所在的右半就是中央 |
| Studio | 官方 ZMK Studio（键位编辑） | 官方功能 + DYA Studio（轨迹球 / 连接 / 设置 / 宏 / 组合键 / 诊断） |
| 板级定义 | `boards/arm/skinner39/`（HWMv1） | `boards/yangxing/keyball_neo39/` + `board.yml`（Zephyr HWMv2） |

### 已启用的 DYA Studio 功能

* **Keymap**：官方 ZMK Studio 键位 / 层编辑，布局预览里会画出轨迹球位置；
  **Macro** 子页可以创建 / 改名 / 删除运行时宏；**Combo** 子页可以编辑运行时组合键
* **Trackball**：CPI、轴方向、smart algorithm、downshift / sample 等参数在线调整；
  运行时可调的输入处理器（速度、旋转、轴吸附、自动鼠标层）
* **Connection**：BLE profile 管理、OS 自动识别、按连接 / OS 切换默认层
* **Settings**：休眠 / 空闲超时等设置、通用 custom settings、电池历史
* **Troubleshooting**：device info、watchdog 重启原因、KSCAN 诊断

### 构建

本地（需要 `west`、Zephyr SDK、`protoc`）：

```sh
make init-standalone   # 依赖下载到 ./dependencies
make build-all         # 输出到 ./build/<artifact>/zephyr/zmk.uf2
```

也可以直接用 GitHub Actions 的 `Build ZMK firmware` 工作流。

### 烧录

| 文件 | 用途 |
| --- | --- |
| `keyball_neo39_right.uf2` | 右半 = **主手（中央）**，接 USB / 连蓝牙的那一半，轨迹球也在这一半 |
| `keyball_neo39_left.uf2` | 左半 = 副手（外设） |
| `keyball_neo39_left_reset.uf2` / `keyball_neo39_right_reset.uf2` | 清空已保存的设置（键位、custom settings、电池历史、BLE 配对），从固件默认值重新开始 |

因为中央 / 外设角色和 keymap 都变了，升级时**两半都要重刷**；保险起见先各刷一次
对应的 `*_reset.uf2`，再刷正式固件。原来的 Bluetooth 配对也需要重新连一次。

### 使用 DYA Studio

1. 用 USB 连接右半（主手）
2. 打开 <https://studio.dya.cormoran.works/>
3. 「Connect via USB」连接键盘

本分支关闭了 Studio 自动锁定（`CONFIG_ZMK_STUDIO_LOCKING=n`），所以默认可以直接
读写。键位里也保留了 `&studio_unlock`：**按住 SPACE（MOUSE 层）+ 左下角那颗键**
即可在需要时解锁。

### 键位上的几处新增行为

* **自动鼠标层**：转动轨迹球 200ms 后自动激活第 4 层（MOUSE），停手 400ms 后自动
  退出，因此不用先按层键就能点击 / 滚轮；这两项都能在 DYA Studio 里改。
* **滚轮层 / snipe 层**：第 5 层（SCROLL）轨迹球变成滚轮，第 6 层（SNIPE）变成
  1/3 速度慢速移动，和 main 分支的行为一致，参数同样可以在 Studio 里调。
* **运行时宏**：DYA Studio 的 Macro 页新建宏后会分配到槽位号（0 ~ 7，见网页里的
  宏列表），键位上用 `&rmacro <槽位号>` 播放。当前固件在 **按住 SPACE + 左下角
  第二颗键** 上绑了 `&rmacro 0` 作示例，空槽位按下去没有动作。默认 8 个宏、每个
  最大 256 字节、名字最长 24 字节（共享 1KB 内存池），可在
  `keyball_neo39_right_defconfig` 里调 `ZMK_RUNTIME_MACRO_*`。
* **运行时组合键**：Combo 页里按槽位编辑「哪几个键位同时按下 → 触发什么行为」，
  也能给槽位起名。固件里**没有预置任何组合键**，所以在网页上添加之前键盘行为不变；
  全局的 timeout / slow-release / require-prior-idle 也在该页设置。默认 8 个槽位、
  每个最多 16 个键位，可通过 `keyball_neo39_right_defconfig` 的
  `ZMK_RUNTIME_COMBO_*` 调整。

### 注意事项

* 板级定义已迁移到 Zephyr **HWMv2**。ZMK `main` 从 Zephyr 4.1 开始要求这一点，
  旧写法（`boards/arm/...` + `Kconfig.board`）在当前 ZMK 上无法构建。
* 主手是**右半**（`ZMK_SPLIT_ROLE_CENTRAL` 在 `keyball_neo39_right` 上）：USB、蓝牙、
  ZMK Studio / DYA Studio 的 RPC 全部在右半，插右半即可。
* 轨迹球也挂在右半，刚好和主手同一半，所以是本地直连、不再需要跨半转发；传感器
  设置对外暴露的键名前缀是 `ball`（例如 `cpi@ball`）。
* `CONFIG_ZMK_BATTERY_HISTORY=y` 会周期性写入 flash（约每小时一次）。如果不看电池
  历史，可以在 `keyball_neo39_right_defconfig` 里关掉这两个开关以减少 flash 写入。
* 布局预览里的轨迹球位置是估算值（`keyball_neo39.dtsi` 的 `trackball_layout`），如果和
  实物不符，改 `x` / `y` / `size` 即可。
* 想换回左手当主手的话，改动集中在 `Kconfig.defconfig`（`ZMK_SPLIT_ROLE_CENTRAL`）、
  两个 `*_defconfig` 和 `build.yaml` 里 `studio-rpc-usb-uart` 的归属。

---

## English

[简体中文](#简体中文) &nbsp;|&nbsp; **English**

### About this keyboard

**Keyball Neo 39** (formerly Skinner39) is a 39-key wireless split keyboard with a nice!view
OLED, a swappable 25 mm / 34 mm trackball and support for both low- and high-profile
switches, in a case with magnetic tenting. It was designed by yangxing, inspired by
Yawkee's keyball family; the larger 47-key sibling is **Keyball Neo 47**, in
`zmk-config-KeyballNeo47`.
Build guide: <https://aeolian-melon-437.notion.site/Skinner39-1a14484f44ee80c3916ad98ebab79145>

The `dya` branch makes it work with **DYA Studio** (cormoran's enhanced ZMK Studio). It
uses the same trackball stack as the keyball `dya-nv` branch: cormoran's PMW3610 driver
(devicetree compatible `cormoran,pmw3610`) plus DYA's custom Studio RPC modules.

`main` is left untouched; all changes live on `dya`, which is also the default branch.

The name shown to the outside world is **Keyball Neo 39**: the Bluetooth / USB device name
and the keyboard and layout names in ZMK Studio (`ZMK_KEYBOARD_NAME`, `display-name`,
`*.zmk.yml`). Board IDs, directories, the keymap and the firmware file names all follow
the same scheme: `keyball_neo39_left` / `keyball_neo39_right`,
`config/keyball_neo39.keymap` and `keyball_neo39_*.uf2` (the old `skinner39*` names are
gone).

This repository has two branches: `dya` (the DYA Studio one, also the default) and `main`
(the original badjeff-driver configuration). This README is identical on both; the table
below spells out the differences.

### Differences from `main`

| Item | main | dya |
| --- | --- | --- |
| ZMK | `zmkfirmware/zmk@main` | `cormoran/zmk@main+dya` |
| Zephyr | whatever ZMK pins | `cormoran/zephyr@v4.1.0+zmk-fixes+nrf-half-duplex-uart` |
| Trackball driver | badjeff `pixart,pmw3610` | cormoran `cormoran,pmw3610` (same as keyball dya-nv) |
| Cross-half input | badjeff split relay module | not needed: the ball sits on the right half, which is the central |
| Studio | official ZMK Studio (keymap editing) | official features + DYA Studio (trackball / connection / settings / macro / combo / diagnostics) |
| Board definition | `boards/arm/skinner39/` (HWMv1) | `boards/yangxing/keyball_neo39/` + `board.yml` (Zephyr HWMv2) |

### DYA Studio features enabled

* **Keymap**: official ZMK Studio key/layer editing, with the trackball drawn in the
  layout preview; the **Macro** tab creates, renames and deletes runtime macros; the
  **Combo** tab edits runtime combos
* **Trackball**: CPI, axis flags, smart algorithm, downshift/sample times and more,
  configured live; runtime input processors (speed, rotation, axis snap, auto mouse
  layer)
* **Connection**: BLE profile management, OS detection, per-connection / per-OS
  default layers
* **Settings**: sleep / idle timeouts, generic custom settings, battery history
* **Troubleshooting**: device info, watchdog reset reasons, KSCAN diagnostics

### Building

Locally (needs `west`, the Zephyr SDK and `protoc`):

```sh
make init-standalone   # downloads dependencies into ./dependencies
make build-all         # artifacts land in ./build/<artifact>/zephyr/zmk.uf2
```

Or use the `Build ZMK firmware` GitHub Actions workflow.

### Flashing

| File | Purpose |
| --- | --- |
| `keyball_neo39_right.uf2` | Right half = **main hand (central)**: USB/BLE to the host, and the trackball |
| `keyball_neo39_left.uf2` | Left half = peripheral |
| `keyball_neo39_left_reset.uf2` / `keyball_neo39_right_reset.uf2` | Wipe stored settings (keymap edits, custom settings, battery history, BLE pairings) and start from firmware defaults |

Because the central/peripheral roles and the keymap changed, **flash both halves** when
upgrading; flashing the matching `*_reset.uf2` first is recommended. Existing Bluetooth
pairings have to be made again.

### Using DYA Studio

1. Connect the right half (main hand) over USB
2. Open <https://studio.dya.cormoran.works/>
3. Press "Connect via USB"

Studio auto-locking is disabled here (`CONFIG_ZMK_STUDIO_LOCKING=n`), so reads and writes
work out of the box. `&studio_unlock` is still bound: **hold SPACE (MOUSE layer) + the
bottom-left key**.

### Keymap additions

* **Auto mouse layer**: 200 ms after the ball starts moving, layer 4 (MOUSE) is held
  active and released 400 ms after it stops, so clicking/scrolling works without
  reaching for a layer key. Both delays are editable in DYA Studio.
* **Scroll / snipe layers**: layer 5 (SCROLL) turns the ball into a wheel, layer 6
  (SNIPE) into 1/3-speed precision movement, matching `main`'s behaviour; the parameters
  are configurable in Studio too.
* **Runtime macros**: a macro created in DYA Studio's Macro tab gets a slot number
  (0–7, shown in the web UI) and is played with `&rmacro <slot>`. This firmware binds
  `&rmacro 0` to **hold SPACE + the second bottom-left key** as an example; an empty slot
  does nothing. Defaults: 8 macros, 256 bytes each, names up to 24 bytes (shared 1 KB
  pool) — tunable via `ZMK_RUNTIME_MACRO_*` in `keyball_neo39_right_defconfig`.
* **Runtime combos**: the Combo tab edits, per slot, which key positions trigger which
  behaviour, plus optional names. **No combo ships in firmware**, so behaviour is
  unchanged until you add one in the web UI; global timeout / slow-release /
  require-prior-idle live there too. Defaults: 8 slots, 16 positions each — tunable via
  `ZMK_RUNTIME_COMBO_*`.

### Notes

* The board definition has moved to Zephyr **HWMv2**, which ZMK `main` (Zephyr 4.1)
  requires; the old `boards/arm/...` + `Kconfig.board` layout no longer builds.
* Right half is the main hand (`ZMK_SPLIT_ROLE_CENTRAL` on `keyball_neo39_right`): USB, BLE
  and every ZMK Studio / DYA Studio RPC live there.
* The trackball also hangs off the right half, so it is a local device — no split relay
  for input, and sensor settings are exposed as `ball`-suffixed keys (e.g. `cpi@ball`).
* `CONFIG_ZMK_BATTERY_HISTORY=y` writes to flash periodically (about once an hour). If
  you don't need battery history, turn those two symbols off in
  `keyball_neo39_right_defconfig` to reduce flash wear.
* The trackball position in the layout preview is an estimate (`trackball_layout` in
  `keyball_neo39.dtsi`); adjust `x` / `y` / `size` to match your case.
* To switch back to a left-hand main hand, change `ZMK_SPLIT_ROLE_CENTRAL` in
  `Kconfig.defconfig`, the two `*_defconfig` files and which half owns
  `studio-rpc-usb-uart` in `build.yaml`.
