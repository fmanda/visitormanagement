const getters = {
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  token: state => state.user.token,
  avatar: state => state.user.avatar,
  department_id: state => state.user.department_id,
  name: state => state.user.name
}
export default getters
