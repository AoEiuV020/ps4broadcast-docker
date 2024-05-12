lp = new LivingProcess();
lp.webapp = app;
lp.setup('','', [])
  .then(lp.prepare())
  .then(lp.config())
  .then(lp.resetTwitchClient())
  .then(lp.configTwitchClient())
  .then(lp.configDanmu())
  .then(lp.start())
  .then(()=>{
        console.log("living");
})
.catch(()=>{
        console.log("down");
});
