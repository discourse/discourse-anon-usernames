import { on } from "@ember/modifier";
import InputTip from "discourse/components/input-tip";
import valueEntered from "discourse/helpers/value-entered";
import { apiInitializer } from "discourse/lib/api";
import { i18n } from "discourse-i18n";
import RandomizerButton from "../components/randomizer-button";

export default apiInitializer((api) => {
  const siteSettings = api.container.lookup("service:site-settings");

  api.renderInOutlet(
    "invite-username-input",
    <template>
      <div class="input-with-randomizer-btn">
        <input
          {{on "focusin" @controller.scrollInputIntoView}}
          {{on "input" @controller.setAccountUsername}}
          type="text"
          value={{@controller.accountUsername}}
          class={{valueEntered @controller.accountUsername}}
          id="new-account-username"
          name="username"
          disabled={{siteSettings.only_generated_usernames}}
          maxlength={{@controller.maxUsernameLength}}
          autocomplete="off"
        />

        <RandomizerButton
          @randomizeFrom={{@controller.accountName}}
          @onGenerate={{@controller.setAccountUsername}}
        />

      </div>
      {{#unless @controller.accountUsername}}
        <label class="alt-placeholder" for="new-account-username">
          {{i18n "user.username.title"}}
        </label>
      {{/unless}}
      <InputTip
        @validation={{@controller.usernameValidation}}
        id="username-validation"
      />
    </template>
  );
});
