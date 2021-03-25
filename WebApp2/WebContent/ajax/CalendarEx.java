import java.util.Calendar;
import java.util.Scanner;

public class CalendarEx {

	public static void main(String[] args) {
		Scanner scan = new Scanner(System.in);
		// 년도
		System.out.print("년도 = ");
		int year = scan.nextInt();
		// 월
		System.out.print("월 = ");
		int month = scan.nextInt(); //9
		
		Calendar date = Calendar.getInstance(); // 오늘날짜 + 시간
		// 날짜 1일로 바꾸기
		date.set(year, month-1, 1);
		
		// 1일에 대한 요일 구하기
		int week = date.get(Calendar.DAY_OF_WEEK);
		
		// 31 -> 1, 3, 5, 7, 8, 10, 12
		// 30 -> 4, 6, 9, 11
		// 28, 29 -> 2
		
		
		/*
		int lastDay = 31;
		switch(month) {
			case 4: 
			case 6: 
			case 9: 
			case 11:
				lastDay = 30;
				break;
			case 2:	// 출력할 달이 2월인지 확인
				if(year%4==0 && year%100!=0 || year%400==0) {// 윤년일때
					lastDay = 29;
				}else {// 윤년이 아닐때
					lastDay = 28;
				}
		}
		*/
		// 위 switch문과 같은 결과값이다.(최대 일수 구하기)
		int lastDay = date.getActualMaximum(Calendar.DAY_OF_MONTH);
		
		//=================================
		// 제목 출력
		System.out.printf("\t\t%d년도 %d월\n",year,month);
		System.out.println("일\t월\t화\t수\t목\t금\t토");
		
		// 공백 출력
		for(int space = 1; space < week; space++) {
			System.out.print("\t");
		}
		
		// 날짜 출력
		for(int day = 1; day <= lastDay; day++) {
			System.out.print(day+"\t");
			if((day + week -1) % 7 == 0) {
				System.out.println("");
			}
		}
	}

}
