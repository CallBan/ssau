import { createRouter, createWebHistory } from "vue-router";
import TopicList from "@/components/TopicList.vue";
import TopicView from "@/components/TopicView.vue";
import PostView from "@/components/PostView.vue";
import CreatePost from "@/components/CreatePost.vue";
import CreateComment from "@/components/CreateComment.vue";

const routes = [
  {
    path: "/",
    name: "Home",
    component: TopicList,
  },
  {
    path: "/topic/:id",
    name: "Topic",
    component: TopicView,
    props: true,
  },
  {
    path: "/topic/:id_topic/post/:id_post",
    name: "Post",
    component: PostView,
    props: true,
  },
  {
    path: "/topic/:id/createPost",
    name: "CreatePost",
    component: CreatePost,
    props: true,
  },
  {
    path: "/topic/:id_topic/post/:id_post/createComment",
    name: "CreateComment",
    component: CreateComment,
    props: true,
  },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
