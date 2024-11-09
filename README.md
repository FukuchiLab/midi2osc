（現在の実装では）KORG nanoKONTROL2 の入力を OSC メッセージに変換して送信する [Processing](https://processing.org/) プログラム。
またその受信デモ。

# 使用ライブラリ
- MidiBus
- oscP5

# OSC アドレスおよびデータ
- ノブ
  - `/knob ID VALUE`: IDは左から0〜7。VALUE は 0〜127 の整数
- スライダー
  - `/slider ID VALUE`: IDは左から0〜7。VALUE は 0〜127 の整数
- ボタン
  - `/button LABEL ID VALUE`: LABEL は文字列として渡される。VALUE は 0 or 1
  - コントロールグループのボタンの場合は、LABEL は S / M / R。ID は左から 0〜7。
  - 再生・停止ボタン類の場合は、ID は 8 となる。LABEL は下記
    - rewind / fastforward / stop / play / rec

https://github.com/user-attachments/assets/8e80b27f-654f-4031-af89-b30344e66035
  - 左上が midi2osc 本体、右下は osc\_receiver\_demo。
