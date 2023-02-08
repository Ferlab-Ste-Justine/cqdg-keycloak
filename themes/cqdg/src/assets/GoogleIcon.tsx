import { ISVGProps } from "./types";

const GoogleIcon = ({ className = "" }: ISVGProps) => (
  <svg
    width="32"
    height="33"
    viewBox="0 0 32 33"
    fill="none"
    className={className}
    xmlns="http://www.w3.org/2000/svg"
  >
    <path
      d="M31.2523 17.2623C31.2523 15.9513 31.1459 14.9946 30.9157 14.0024H15.9451V19.9198H24.7325C24.5554 21.3903 23.5987 23.6049 21.4726 25.093L21.4428 25.2911L26.1763 28.958L26.5042 28.9908C29.516 26.2092 31.2523 22.1166 31.2523 17.2623"
      fill="#4285F4"
    />
    <path
      d="M15.9451 32.853C20.2502 32.853 23.8643 31.4356 26.5042 28.9907L21.4727 25.093C20.1262 26.032 18.3191 26.6875 15.9451 26.6875C11.7285 26.6875 8.14978 23.906 6.87406 20.0615L6.68707 20.0774L1.76517 23.8865L1.70081 24.0654C4.32285 29.2741 9.70874 32.853 15.9451 32.853Z"
      fill="#34A853"
    />
    <path
      d="M6.87401 20.0616C6.5374 19.0695 6.3426 18.0064 6.3426 16.908C6.3426 15.8095 6.5374 14.7466 6.85631 13.7544L6.84739 13.5431L1.86382 9.67285L1.70076 9.75041C0.620092 11.9119 0 14.3391 0 16.908C0 19.4769 0.620092 21.9041 1.70076 24.0655L6.87401 20.0616"
      fill="#FBBC05"
    />
    <path
      d="M15.9451 7.12826C18.9392 7.12826 20.9588 8.42158 22.1105 9.50237L26.6105 5.1086C23.8468 2.53968 20.2502 0.962891 15.9451 0.962891C9.70874 0.962891 4.32285 4.54164 1.70081 9.75031L6.85635 13.7543C8.14978 9.90982 11.7285 7.12826 15.9451 7.12826"
      fill="#EB4335"
    />
  </svg>
);

export default GoogleIcon;
