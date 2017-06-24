#include <iostream>

using namespace std;

#define H_Length 4
#define X_Length 6

void DoubleFIFO()
{
    cout<<"Double FIFO Buffer :\n";

    int h[]={1, 2, 3, 4};                //h[n]
    int x[]={1, 2, 3, 4, 5, 6};          //x[n]

    cout<<"\nh[n] is :\n";
    for (int a=0;a<H_Length;a++)
    {
        cout<<h[a]<<"\t";
    }
    cout<<endl;

    cout<<"\nx[n] is :\n";
    for (int a=0;a<X_Length;a++)
    {
        cout<<x[a]<<"\t";
    }
    cout<<endl;

    int y[X_Length+H_Length-1];                     //declaring y[n]
    int Buffer[2*H_Length]={0};          //declaring buffer

    int Index=H_Length;                //declaring index=length of h + 1
    int sum=0;
    int temp[H_Length];
    for(int i=0;i<X_Length+H_Length-1;i++)
    {
        if(Index>=2*H_Length)
        {
            for (int j=0;j<H_Length;j++)
            {
                Buffer[j]=Buffer[j+H_Length];
            }
            Index=H_Length;
        }
        if(i<=X_Length)
        {
            Buffer[Index]=x[i];
        }
        else
        {
            Buffer[Index]=0;
        }

        temp[H_Length]={0};
        sum=0;

        for (int k=0;k<H_Length;k++)
        {
            temp[k]=h[k]*Buffer[Index-k];
            sum=sum+temp[k];
        }

        y[i]=sum;
        Index++;
    }





    cout<<"\nResult of convolution is :\n";
    for (int b=0;b<X_Length+H_Length-1;b++)
    {
        cout<<y[b]<<"\t";
    }
}

void DoubleCircular()
{
    cout<<"\n\n\nDouble Circular Buffer :\n";

    int h[]={1, 2, 3, 4};                //h[n]
    int x[]={1, 2, 3, 4, 5, 6};          //x[n]

    cout<<"\nh[n] is :\n";
    for (int a=0;a<H_Length;a++)
    {
        cout<<h[a]<<"\t";
    }
    cout<<endl;

    cout<<"\nx[n] is :\n";
    for (int a=0;a<X_Length;a++)
    {
        cout<<x[a]<<"\t";
    }
    cout<<endl;

    int y[X_Length+H_Length-1];                     //declaring y[n]
    int Buffer[2*H_Length]={0};          //declaring buffer

    int Index1=0;
    int Index2=H_Length;                //declaring index=length of h + 1
    int sum=0;
    int temp[H_Length];
    for(int i=0;i<X_Length+H_Length-1;i++)
    {
        if(Index2>=2*H_Length)
        {
            Index1=0;
            Index2=H_Length;
        }
        if(i<=X_Length)
        {
            Buffer[Index1]=x[i];
            Buffer[Index2]=x[i];
        }
        else
        {
            Buffer[Index1]=0;
            Buffer[Index2]=0;
        }

        temp[H_Length]={0};
        sum=0;

        for (int k=0;k<H_Length;k++)
        {
            temp[k]=h[k]*Buffer[Index2-k];
            sum=sum+temp[k];
        }
        y[i]=sum;
        Index1++;
        Index2++;
    }





    cout<<"\nResult of convolution is :\n";
    for (int b=0;b<X_Length+H_Length-1;b++)
    {
        cout<<y[b]<<"\t";
    }
}



void Circular()
{
	int h[] = {1, 2, 3, 4};          //Initializing h

	int x[] = { 1, 2, 3, 4, 5, 6};       //Initializing x

	int y[H_Length+X_Length-1] = { 0 };             //Initializing result array
	int Buffer[H_Length] = { 0 };             //Buffer array

	int num = 0;            //Counter

	for (int i = 0; i < X_Length+H_Length-1; i++)
	{
		int sum = 0;
		if (i < X_Length)
		{
			Buffer[i%H_Length] = x[i];
		}
		else
		{
			Buffer[i%H_Length] = 0;
		}
		int temp = 0;
		temp = num;
		int temp2 = 0;
		bool check = false;
		for (int j = 0; j < H_Length; j++)
		{
			if (temp -1 - j<0 && check==false)
			{
				temp = H_Length;
				check = true;
				temp2 = -1;
			}
			else if(!check)
			{
				temp2 = j;
			}
			if (check)
			{
				temp2++;
			}
			int inde = temp - 1 - temp2;
			sum = sum + (h[j] * Buffer[inde]);
		}
		y[i] = sum;
	}
	for (int i = 0; i < X_Length + H_Length -1; i++)
		cout << y[i]<<"  ";
}



int main()
{
    Circular();
   //DoubleFIFO();
   //DoubleCircular();
   return 0;
}
