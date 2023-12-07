
// trang này không có gì đâu, nó tự động chuyển hướng qua trang đăng nhập
export default function Home() {
  const handleAuthorization = (role) => {
    const cookies = document.cookie.split('; ');
    for (const cookie of cookies) {
      const [name, value] = cookie.split('=');
      if(name === role) {
        return true
      }
    }
    window.location.href = 'http://localhost:3000/login';
  }
  handleAuthorization('...')
}