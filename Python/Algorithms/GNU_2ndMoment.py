class OnlineVariance:
    def __init__(self):
        self.n = 0
        self.mean = 0.0
        self.M2 = 0.0

    def update(self, x):
        self.n += 1
        delta = x - self.mean
        self.mean += delta / self.n
        delta2 = x - self.mean
        self.M2 += delta * delta2

    def get_mean(self):
        return self.mean

    def get_variance(self):
        if self.n < 2:
            return 0.0
        return self.M2 / (self.n - 1) 

ov = OnlineVariance()
data = [1.0, 2.0, 3.0, 4.0, 5.0]

for x in data:
    ov.update(x)
    print(f"Po {ov.n} hodnotách: průměr = {ov.get_mean():.2f}, rozptyl = {ov.get_variance():.2f}")
