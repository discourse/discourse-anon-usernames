import Component from "@glimmer/component";
import { action } from "@ember/object";
import { service } from "@ember/service";
import DButton from "discourse/components/d-button";

const getFirstName = (fullName) => fullName.split(" ")[0];

export default class RandomizerButton extends Component {
  @service siteSettings;

  get randomWordsList() {
    return this.siteSettings.random_words_list.split("|") || [];
  }

  @action
  async generate() {
    const randomizeFrom = getFirstName(this.args.randomizeFrom);
    const color =
      this.randomWordsList[
        Math.floor(Math.random() * this.randomWordsList.length)
      ];
    this.args.onGenerate({
      target: {
        value: randomizeFrom + color + Math.floor(Math.random() * 1000),
      },
    });
  }

  get canGenerate() {
    return (
      this.args.randomizeFrom &&
      this.args.randomizeFrom.length !== 0 &&
      getFirstName(this.args.randomizeFrom).trim() !==
        this.args.randomizeFrom.trim()
    );
  }

  <template>
    <DButton
      @icon="rotate"
      class="btn-primary randomizer-btn"
      @action={{this.generate}}
      disabled={{if this.canGenerate false true}}
    />
  </template>
}
