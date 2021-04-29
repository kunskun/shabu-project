<template>
  <div class="container is-widescreen">
    <section class="hero">
      <div class="hero-body">
        <p class="title">Home + login</p>
      </div>
    </section>
    <section class="section" id="app">
      <div class="content">
        <div class="columns is-multiline">
          <div class="column is-3" v-for="blog in blogs" :key="blog.id">
            <div class="card">
              <div class="card-image pt-5">
                <figure class="image">
                  <img style="height: 120px" :src="blog.file_path" alt="Placeholder image" />
                </figure>
              </div>
              <div class="card-content">
                <div class="title">{{ blog.title }}</div>
                <div class="content">{{ blog.content }}</div>
              </div>
              <footer class="card-footer">
                <a class="card-footer-item">Read more...</a>
                <a class="card-footer-item">
                  <span class="icon-text">
                    <span class="icon">
                      <i class="far fa-heart"></i>
                    </span>
                    <span>Like</span>
                  </span>
                </a>
              </footer>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
export default {
    data() {
      return {}
    }
  }
</script>

<style scoped>
</style>