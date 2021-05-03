<template>
  <div>
    <div class="container is-fluid mt-5">
      <div class="columns is-centered">
        <div class="column is-4">
          <h1 class="title has-text-left">สมัครสมาชิก</h1>
          <!-- Sign up form -->
          <div class="field">
            <label class="label has-text-left">Username</label>
            <div class="control has-icons-left">
              <input
                class="input"
                type="text"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-user"></i>
              </span>
            </div>
            <!-- <template v-if="$v.username.$error">
              <p class="help is-danger" v-if="!$v.username.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.username.minLength">
                Must be at least 5 characters
              </p>
            </template> -->
          </div>

          <div class="field">
            <label class="label has-text-left">Password</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="password"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-lock"></i>
              </span>
            </div>
            <!-- <template v-if="$v.password.$error">
              <p class="help is-danger" v-if="!$v.password.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.password.minLength">
                Must be at least 8 character
              </p>
              <p class="help is-danger" v-if="!$v.password.complex">
                Password too easy
              </p>
            </template> -->
          </div>

          <div class="field">
            <label class="label has-text-left">Confirm Password</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="password"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-lock"></i>
              </span>
            </div>
            <!-- <template v-if="$v.confirm_password.$error">
              <p class="help is-danger" v-if="!$v.confirm_password.sameAs">
                Password not match
              </p>
            </template> -->
          </div>

          <div class="field">
            <label class="label has-text-left">Email</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-envelope"></i>
              </span>
            </div>
            <!-- <template v-if="$v.email.$error">
              <p class="help is-danger" v-if="!$v.email.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.email.email">Invalid Email</p>
            </template> -->
          </div>

          <div class="field">
            <label class="label has-text-left">Mobile Number</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-mobile"></i>
              </span>
            </div>
            <!-- <template v-if="$v.mobile.$error">
              <p class="help is-danger" v-if="!$v.mobile.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.mobile.mobile">
                Invalid Mobile Number
              </p>
            </template> -->
          </div>

          <div class="field">
            <label class="label has-text-left">First Name</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
              />
            </div>
            <!-- <template v-if="$v.first_name.$error">
              <p class="help is-danger" v-if="!$v.first_name.required">
                This field is required
              </p>
            </template> -->
          </div>

          <div class="field">
            <label class="label has-text-left">Last Name</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
              />
            </div>
            <!-- <template v-if="$v.last_name.$error">
              <p class="help is-danger" v-if="!$v.last_name.required">
                This field is required
              </p>
            </template> -->
          </div>

          <button class="button is-primary is-fullwidth">Sign Up</button>

          <p class="my-3 has-text-dark has-text-left">เคยสมัครไว้แล้วเหรอ? <router-link to="/">
              Login
            </router-link></p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {
  required,
  email,
  helpers,
  minLength,
  maxLength,
  sameAs,
} from "vuelidate/lib/validators";

function mobile(value) {
  return !helpers.req(value) || !!value.match(/0[0-9]{9}/);
}

function complexPassword(value) {
  if (!(value.match(/[a-z]/) && value.match(/[A-Z]/) && value.match(/[0-9]/))) {
    return false;
  }
  return true;
}

export default {
  data() {
    return {
      username: "",
      password: "",
      confirm_password: "",
      email: "",
      mobile: "",
      first_name: "",
      last_name: "",
    };
  },
  validations: {
    email: {
      required: required,
      email: email,
    },
    mobile: {
      required: required,
      mobile: mobile,
    },
    password: {
      required: required,
      minLength: minLength(8),
      complex: complexPassword,
    },
    confirm_password: {
      sameAs: sameAs("password"),
    },
    username: {
      required: required,
      minLength: minLength(5),
      maxLength: maxLength(20),
    },
    first_name: {
      required: required,
    },
    last_name: {
      required: required,
    },
  },
};
</script>