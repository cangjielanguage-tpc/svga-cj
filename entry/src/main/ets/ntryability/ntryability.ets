import { AbilityConstant, AbilityStage, Want, Configuration } from '@kit.AbilityKit';
import { requireCJLib } from "libark_interop_loader.so";

interface cjOps {
  ark_createCJAbilityStage(name: string, jsAbilityStage: AbilityStage): number

  ark_AbilityStageOnCreate(id: number): void

  ark_AbilityStageOnAcceptWant(id: number, want: Want): string

  ark_AbilityStageOnNewProcessRequest(id: number, want: Want): string

  ark_AbilityStageOnConfigurationUpdate(id: number, newConfig: Configuration): void

  ark_AbilityStageOnMemoryLevel(id: number, level: AbilityConstant.MemoryLevel): void

  ark_AbilityStageOnDestroy(id: number): void
}

let lib: cjOps

export default class ntryability extends AbilityStage {
  cjAbilityStage: number = 0

  onCreate() {
    console.log('MyAbilityStage.onCreate is called');
    lib = requireCJLib("libtpc.AbilityKit.interop_libs.ability_stage_interop.so") as cjOps
    requireCJLib("libohos_app_cangjie_entry.entryAbility.so")
    this.cjAbilityStage = lib.ark_createCJAbilityStage("ntryability", this)
    lib.ark_AbilityStageOnCreate(this.cjAbilityStage)
  }

  onAcceptWant(want: Want) {
    console.log('ntryability.onAcceptWant called');
    return lib.ark_AbilityStageOnAcceptWant(this.cjAbilityStage, want);
  }

  onNewProcessRequest(want: Want) {
    console.log('ntryability.onNewProcessRequest called');
    return lib.ark_AbilityStageOnNewProcessRequest(this.cjAbilityStage, want);
  }

  onConfigurationUpdate(newConfig: Configuration) {
    console.log(`onConfigurationUpdate, language: ${newConfig.language}`);
    lib.ark_AbilityStageOnConfigurationUpdate(this.cjAbilityStage, newConfig)
  }

  onMemoryLevel(level: AbilityConstant.MemoryLevel) {
    console.log(`onMemoryLevel, level: ${JSON.stringify(level)}`);
    lib.ark_AbilityStageOnMemoryLevel(this.cjAbilityStage, level)
  }

  onDestroy() {
    console.log('ntryability.onDestroy is called');
    lib.ark_AbilityStageOnDestroy(this.cjAbilityStage)
  }
}
