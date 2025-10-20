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

  fetchRandomWord() {
    if (this.randomWordsList.length === 0) {
      return "";
    }
    return this.randomWordsList[
      Math.floor(Math.random() * this.randomWordsList.length)
    ];
  }

  @action
  async generate() {
    const randomizeFrom = getFirstName(this.args.randomizeFrom);
    const randomWord = this.fetchRandomWord();

    this.args.onGenerate({
      target: {
        value: randomizeFrom + randomWord + Math.floor(Math.random() * 1000),
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
