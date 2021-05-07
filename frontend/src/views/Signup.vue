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
                v-model="$v.username.$model"
                :class="{ 'is-danger': $v.username.$error }"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-user"></i>
              </span>
            </div>
            <template v-if="$v.username.$error">
              <p class="help is-danger" v-if="!$v.username.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.username.minLength">
                Must be at least 5 characters
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label has-text-left">Password</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="password"
                v-model="$v.password.$model"
                :class="{ 'is-danger': $v.password.$error }"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-lock"></i>
              </span>
            </div>
            <template v-if="$v.password.$error">
              <p class="help is-danger" v-if="!$v.password.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.password.minLength">
                Must be at least 8 character
              </p>
              <p class="help is-danger" v-if="!$v.password.complex">
                Password too easy
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label has-text-left">Confirm Password</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="password"
                v-model="$v.confirm_password.$model"
                :class="{ 'is-danger': $v.confirm_password.$error }"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-lock"></i>
              </span>
            </div>
            <template v-if="$v.confirm_password.$error">
              <p class="help is-danger" v-if="!$v.confirm_password.sameAs">
                Password not match
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label has-text-left">Email</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
                v-model="$v.email.$model"
                :class="{ 'is-danger': $v.email.$error }"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-envelope"></i>
              </span>
            </div>
            <template v-if="$v.email.$error">
              <p class="help is-danger" v-if="!$v.email.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.email.email">Invalid Email</p>
            </template>
          </div>

          <div class="field">
            <label class="label has-text-left">Mobile Number</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
                v-model="$v.mobile.$model"
                :class="{ 'is-danger': $v.mobile.$error }"
              />
              <span class="icon is-small is-left">
                <i class="fa fa-mobile"></i>
              </span>
            </div>
            <template v-if="$v.mobile.$error">
              <p class="help is-danger" v-if="!$v.mobile.required">
                This field is required
              </p>
              <p class="help is-danger" v-if="!$v.mobile.mobile">
                Invalid Mobile Number
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label has-text-left">First Name</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
                v-model="$v.first_name.$model"
                :class="{ 'is-danger': $v.first_name.$error }"
              />
            </div>
            <template v-if="$v.first_name.$error">
              <p class="help is-danger" v-if="!$v.first_name.required">
                This field is required
              </p>
            </template>
          </div>

          <div class="field">
            <label class="label has-text-left">Last Name</label>
            <div class="control has-icons-left has-icons-right">
              <input
                class="input"
                type="text"
                v-model="$v.last_name.$model"
                :class="{ 'is-danger': $v.last_name.$error }"
              />
            </div>
            <template v-if="$v.last_name.$error">
              <p class="help is-danger" v-if="!$v.last_name.required">
                This field is required
              </p>
            </template>
          </div>

          <button class="button is-primary is-fullwidth" @click="submit">
            Sign Up
          </button>

          <p class="my-3 has-text-dark has-text-left">
            เคยสมัครไว้แล้วเหรอ? <router-link to="/"> Login </router-link>
          </p>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import axios from "axios";
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
      user_id: 0,
    };
  },
  mounted() {
    this.getUserId();
  },
  methods: {
    getUserId() {
      axios
        .get("http://localhost:3000/user")
        .then((response) => {
          this.user_id = response.data[0].id+1
        })
        .catch((err) => {
          console.log(err);
        });
    },
    submit() {
      // Validate all fields
      this.$v.$touch();

      // เช็คว่าในฟอร์มไม่มี error
      if (!this.$v.$invalid) {
        let data = {
          username: this.username,
          password: this.password,
          confirm_password: this.confirm_password,
          email: this.email,
          mobile: this.mobile,
          first_name: this.first_name,
          last_name: this.last_name,
          user_id:this.user_id
        };

        axios
          .post("http://localhost:3000/user/signup", data)
          .then(() => {
            alert("Sign up Success");
            this.$router.push({path: '/'})
          })
          .catch((err) => {
            console.log(err);
          });
      }
    },
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
      required: required,
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