BritasArmorPackB42 — SecDev 合包（原模组 + B42Fix 缝合）
========================================================

来源
- 工坊 3780298456 / BritasArmorPackB42 1.3.2（汉化与夜视内置包）
- Resource/BritasArmorPackB42Fix 1.0.0（穿戴层级与容器槽修复）

缝合内容（相对原模组新增）
- 42/media/registries.lua
- 42/media/lua/shared/BritasArmorPackB42Fix.lua
- 42/media/lua/shared/NPCs/BritasArmorPackB42Fix_BodyLocations.lua

Mod ID
- BritasArmorPackB42（与工坊同 ID，便于服务器替换启用）

注意
1. 只启用本合包，不要再开 BritasArmorPackB42Fix（已列入 incompatible）
2. 仍禁止与 Brita_2、独立 NVFramework 同开
3. 适用 PZ 42.20.x；改完模组后需完全退出游戏再进

多人
Mods 列表只需：BritasArmorPackB42
mod.info 编码
- 已改为 UTF-8（无 BOM），与 B42 模组列表读取一致；原工坊包曾为 GBK，会导致名称/介绍乱码。
