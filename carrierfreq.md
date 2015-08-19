# Carrier frequency #

panStamps can work in both 868/915 MHz ISM bands without any hardware modification. However, the panStamp library always sets the carrier frequency to 868 MHz by default. If you wish to work in the 915 MHz band then you simply have to add a line of code, just after initializing the panStamp in your Arduino sketch:

```
void setup()
{
  // Init panStamp
  panstamp.init();

  // Set carrier frequency to 915 MHz
  panstamp.cc1101.setCarrierFreq(CFREQ_915);
}
```